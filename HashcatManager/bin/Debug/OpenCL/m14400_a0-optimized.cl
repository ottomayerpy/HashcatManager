/**
 * Author......: See docs/credits.txt
 * License.....: MIT
 */

#include "inc_vendor.cl"
#include "inc_hash_constants.h"
#include "inc_hash_functions.cl"
#include "inc_types.cl"
#include "inc_common.cl"
#include "inc_rp_optimized.h"
#include "inc_rp_optimized.cl"
#include "inc_simd.cl"
#include "inc_hash_sha1.cl"

#if   VECT_SIZE == 1
#define uint_to_hex_lower8_le(i) (u32x) (l_bin2asc[(i)])
#elif VECT_SIZE == 2
#define uint_to_hex_lower8_le(i) (u32x) (l_bin2asc[(i).s0], l_bin2asc[(i).s1])
#elif VECT_SIZE == 4
#define uint_to_hex_lower8_le(i) (u32x) (l_bin2asc[(i).s0], l_bin2asc[(i).s1], l_bin2asc[(i).s2], l_bin2asc[(i).s3])
#elif VECT_SIZE == 8
#define uint_to_hex_lower8_le(i) (u32x) (l_bin2asc[(i).s0], l_bin2asc[(i).s1], l_bin2asc[(i).s2], l_bin2asc[(i).s3], l_bin2asc[(i).s4], l_bin2asc[(i).s5], l_bin2asc[(i).s6], l_bin2asc[(i).s7])
#elif VECT_SIZE == 16
#define uint_to_hex_lower8_le(i) (u32x) (l_bin2asc[(i).s0], l_bin2asc[(i).s1], l_bin2asc[(i).s2], l_bin2asc[(i).s3], l_bin2asc[(i).s4], l_bin2asc[(i).s5], l_bin2asc[(i).s6], l_bin2asc[(i).s7], l_bin2asc[(i).s8], l_bin2asc[(i).s9], l_bin2asc[(i).sa], l_bin2asc[(i).sb], l_bin2asc[(i).sc], l_bin2asc[(i).sd], l_bin2asc[(i).se], l_bin2asc[(i).sf])
#endif

DECLSPEC void append_4 (const u32 offset, u32 *w0, u32 *w1, u32 *w2, u32 *w3, const u32 src_r0)
{
  u32 tmp[2];

  switch (offset & 3)
  {
    case  0:  tmp[0] = src_r0;
              tmp[1] = 0;
              break;
    case  1:  tmp[0] = src_r0 <<  8;
              tmp[1] = src_r0 >> 24;
              break;
    case  2:  tmp[0] = src_r0 << 16;
              tmp[1] = src_r0 >> 16;
              break;
    case  3:  tmp[0] = src_r0 << 24;
              tmp[1] = src_r0 >>  8;
              break;
  }

  switch (offset / 4)
  {
    case  0:  w0[0] |= tmp[0];
              w0[1]  = tmp[1];
              break;
    case  1:  w0[1] |= tmp[0];
              w0[2]  = tmp[1];
              break;
    case  2:  w0[2] |= tmp[0];
              w0[3]  = tmp[1];
              break;
    case  3:  w0[3] |= tmp[0];
              w1[0]  = tmp[1];
              break;
    case  4:  w1[0] |= tmp[0];
              w1[1]  = tmp[1];
              break;
    case  5:  w1[1] |= tmp[0];
              w1[2]  = tmp[1];
              break;
    case  6:  w1[2] |= tmp[0];
              w1[3]  = tmp[1];
              break;
    case  7:  w1[3] |= tmp[0];
              w2[0]  = tmp[1];
              break;
    case  8:  w2[0] |= tmp[0];
              w2[1]  = tmp[1];
              break;
    case  9:  w2[1] |= tmp[0];
              w2[2]  = tmp[1];
              break;
    case 10:  w2[2] |= tmp[0];
              w2[3]  = tmp[1];
              break;
    case 11:  w2[3] |= tmp[0];
              w3[0]  = tmp[1];
              break;
    case 12:  w3[0] |= tmp[0];
              w3[1]  = tmp[1];
              break;
    case 13:  w3[1] |= tmp[0];
              w3[2]  = tmp[1];
              break;
    case 14:  w3[2] |= tmp[0];
              w3[3]  = tmp[1];
              break;
    case 15:  w3[3] |= tmp[0];
              break;
  }
}

DECLSPEC void shift_2 (u32 *w0, u32 *w1, u32 *w2, u32 *w3)
{
  w3[3] = w3[2] >> 16 | w3[3] << 16;
  w3[2] = w3[1] >> 16 | w3[2] << 16;
  w3[1] = w3[0] >> 16 | w3[1] << 16;
  w3[0] = w2[3] >> 16 | w3[0] << 16;
  w2[3] = w2[2] >> 16 | w2[3] << 16;
  w2[2] = w2[1] >> 16 | w2[2] << 16;
  w2[1] = w2[0] >> 16 | w2[1] << 16;
  w2[0] = w1[3] >> 16 | w2[0] << 16;
  w1[3] = w1[2] >> 16 | w1[3] << 16;
  w1[2] = w1[1] >> 16 | w1[2] << 16;
  w1[1] = w1[0] >> 16 | w1[1] << 16;
  w1[0] = w0[3] >> 16 | w1[0] << 16;
  w0[3] = w0[2] >> 16 | w0[3] << 16;
  w0[2] = w0[1] >> 16 | w0[2] << 16;
  w0[1] = w0[0] >> 16 | w0[1] << 16;
  w0[0] =           0 | w0[0] << 16;
}

__kernel void m14400_m04 (__global pw_t *pws, __constant const kernel_rule_t *rules_buf, __global const pw_t *combs_buf, __global const bf_t *bfs_buf, __global void *tmps, __global void *hooks, __global const u32 *bitmaps_buf_s1_a, __global const u32 *bitmaps_buf_s1_b, __global const u32 *bitmaps_buf_s1_c, __global const u32 *bitmaps_buf_s1_d, __global const u32 *bitmaps_buf_s2_a, __global const u32 *bitmaps_buf_s2_b, __global const u32 *bitmaps_buf_s2_c, __global const u32 *bitmaps_buf_s2_d, __global plain_t *plains_buf, __global const digest_t *digests_buf, __global u32 *hashes_shown, __global const salt_t *salt_bufs, __global const void *esalt_bufs, __global u32 *d_return_buf, __global u32 *d_scryptV0_buf, __global u32 *d_scryptV1_buf, __global u32 *d_scryptV2_buf, __global u32 *d_scryptV3_buf, const u32 bitmap_mask, const u32 bitmap_shift1, const u32 bitmap_shift2, const u32 salt_pos, const u32 loop_pos, const u32 loop_cnt, const u32 il_cnt, const u32 digests_cnt, const u32 digests_offset, const u32 combs_mode, const u64 gid_max)
{
  /**
   * modifier
   */

  const u64 gid = get_global_id (0);
  const u64 lid = get_local_id (0);
  const u64 lsz = get_local_size (0);

  /**
   * bin2asc table
   */

  __local u32 l_bin2asc[256];

  for (u32 i = lid; i < 256; i += lsz)
  {
    const u32 i0 = (i >> 0) & 15;
    const u32 i1 = (i >> 4) & 15;

    l_bin2asc[i] = ((i0 < 10) ? '0' + i0 : 'a' - 10 + i0) << 0
                 | ((i1 < 10) ? '0' + i1 : 'a' - 10 + i1) << 8;
  }

  barrier (CLK_LOCAL_MEM_FENCE);

  if (gid >= gid_max) return;

  /**
   * base
   */

  u32 pw_buf0[4];
  u32 pw_buf1[4];

  pw_buf0[0] = pws[gid].i[0];
  pw_buf0[1] = pws[gid].i[1];
  pw_buf0[2] = pws[gid].i[2];
  pw_buf0[3] = pws[gid].i[3];
  pw_buf1[0] = pws[gid].i[4];
  pw_buf1[1] = pws[gid].i[5];
  pw_buf1[2] = pws[gid].i[6];
  pw_buf1[3] = pws[gid].i[7];

  const u32 pw_len = pws[gid].pw_len;

  /**
   * salt
   */

  const u32 dashes = 0x2d2d2d2d;

  u32 salt_buf0[4];
  u32 salt_buf1[4];
  u32 salt_buf2[4];
  u32 salt_buf3[4];

  salt_buf0[0] = salt_bufs[salt_pos].salt_buf[0];
  salt_buf0[1] = salt_bufs[salt_pos].salt_buf[1];
  salt_buf0[2] = salt_bufs[salt_pos].salt_buf[2];
  salt_buf0[3] = salt_bufs[salt_pos].salt_buf[3];
  salt_buf1[0] = salt_bufs[salt_pos].salt_buf[4];
  salt_buf1[1] = 0;
  salt_buf1[2] = 0;
  salt_buf1[3] = 0;
  salt_buf2[0] = 0;
  salt_buf2[1] = 0;
  salt_buf2[2] = 0;
  salt_buf2[3] = 0;
  salt_buf3[0] = 0;
  salt_buf3[1] = 0;
  salt_buf3[2] = 0;
  salt_buf3[3] = 0;

  shift_2 (salt_buf0, salt_buf1, salt_buf2, salt_buf3);

  salt_buf0[0] |= dashes >> 16;
  salt_buf1[1] |= dashes << 16;

  salt_buf0[0] = swap32_S (salt_buf0[0]);
  salt_buf0[1] = swap32_S (salt_buf0[1]);
  salt_buf0[2] = swap32_S (salt_buf0[2]);
  salt_buf0[3] = swap32_S (salt_buf0[3]);
  salt_buf1[0] = swap32_S (salt_buf1[0]);
  salt_buf1[1] = swap32_S (salt_buf1[1]);
  salt_buf1[2] = swap32_S (salt_buf1[2]);
  salt_buf1[3] = swap32_S (salt_buf1[3]);
  salt_buf2[0] = swap32_S (salt_buf2[0]);
  salt_buf2[1] = swap32_S (salt_buf2[1]);
  salt_buf2[2] = swap32_S (salt_buf2[2]);
  salt_buf2[3] = swap32_S (salt_buf2[3]);
  salt_buf3[0] = swap32_S (salt_buf3[0]);
  salt_buf3[1] = swap32_S (salt_buf3[1]);
  salt_buf3[2] = swap32_S (salt_buf3[2]);
  salt_buf3[3] = swap32_S (salt_buf3[3]);

  const u32 salt_len_orig = salt_bufs[salt_pos].salt_len;

  const u32 salt_len_new = 2 + salt_len_orig + 2;

  /**
   * loop
   */

  for (u32 il_pos = 0; il_pos < il_cnt; il_pos += VECT_SIZE)
  {
    u32x w0[4] = { 0 };
    u32x w1[4] = { 0 };
    u32x w2[4] = { 0 };
    u32x w3[4] = { 0 };

    const u32x out_len_orig = apply_rules_vect (pw_buf0, pw_buf1, pw_len, rules_buf, il_pos, w0, w1);

    append_4 (out_len_orig, w0, w1, w2, w3, dashes);

    shift_2 (w0, w1, w2, w3);

    w0[0] |= dashes >> 16;

    const u32x out_len_new = 2 + out_len_orig + 4;

    append_0x80_4x4_VV (w0, w1, w2, w3, out_len_new);

    w0[0] = swap32 (w0[0]);
    w0[1] = swap32 (w0[1]);
    w0[2] = swap32 (w0[2]);
    w0[3] = swap32 (w0[3]);
    w1[0] = swap32 (w1[0]);
    w1[1] = swap32 (w1[1]);
    w1[2] = swap32 (w1[2]);
    w1[3] = swap32 (w1[3]);
    w2[0] = 0;
    w2[1] = 0;
    w2[2] = 0;
    w2[3] = 0;
    w3[0] = 0;
    w3[1] = 0;
    w3[2] = 0;
    w3[3] = 0;

    /**
     * prepend salt
     */

    const u32x out_salt_len = salt_len_new + out_len_new;

    u32x t0[4];
    u32x t1[4];
    u32x t2[4];
    u32x t3[4];

    t0[0] = salt_buf0[0];
    t0[1] = salt_buf0[1];
    t0[2] = salt_buf0[2];
    t0[3] = salt_buf0[3];
    t1[0] = salt_buf1[0];
    t1[1] = salt_buf1[1];
    t1[2] = w0[0];
    t1[3] = w0[1];
    t2[0] = w0[2];
    t2[1] = w0[3];
    t2[2] = w1[0];
    t2[3] = w1[1];
    t3[0] = w1[2];
    t3[1] = w1[3];
    t3[2] = 0;
    t3[3] = out_salt_len * 8;

    /**
     * sha1
     */

    u32x digest[5];

    digest[0] = SHA1M_A;
    digest[1] = SHA1M_B;
    digest[2] = SHA1M_C;
    digest[3] = SHA1M_D;
    digest[4] = SHA1M_E;

    sha1_transform_vector (t0, t1, t2, t3, digest);

    for (int i = 1; i < 10; i++)
    {
      u32 s[10];

      s[0] = uint_to_hex_lower8_le ((digest[0] >> 16) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[0] >> 24) & 255) << 16;
      s[1] = uint_to_hex_lower8_le ((digest[0] >>  0) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[0] >>  8) & 255) << 16;
      s[2] = uint_to_hex_lower8_le ((digest[1] >> 16) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[1] >> 24) & 255) << 16;
      s[3] = uint_to_hex_lower8_le ((digest[1] >>  0) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[1] >>  8) & 255) << 16;
      s[4] = uint_to_hex_lower8_le ((digest[2] >> 16) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[2] >> 24) & 255) << 16;
      s[5] = uint_to_hex_lower8_le ((digest[2] >>  0) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[2] >>  8) & 255) << 16;
      s[6] = uint_to_hex_lower8_le ((digest[3] >> 16) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[3] >> 24) & 255) << 16;
      s[7] = uint_to_hex_lower8_le ((digest[3] >>  0) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[3] >>  8) & 255) << 16;
      s[8] = uint_to_hex_lower8_le ((digest[4] >> 16) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[4] >> 24) & 255) << 16;
      s[9] = uint_to_hex_lower8_le ((digest[4] >>  0) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[4] >>  8) & 255) << 16;

      t0[0] = salt_buf0[0];
      t0[1] = salt_buf0[1];
      t0[2] = salt_buf0[2];
      t0[3] = salt_buf0[3];
      t1[0] = salt_buf1[0];
      t1[1] = salt_buf1[1];
      t1[2] = s[0];
      t1[3] = s[1];
      t2[0] = s[2];
      t2[1] = s[3];
      t2[2] = s[4];
      t2[3] = s[5];
      t3[0] = s[6];
      t3[1] = s[7];
      t3[2] = s[8];
      t3[3] = s[9];

      digest[0] = SHA1M_A;
      digest[1] = SHA1M_B;
      digest[2] = SHA1M_C;
      digest[3] = SHA1M_D;
      digest[4] = SHA1M_E;

      sha1_transform_vector (t0, t1, t2, t3, digest);

      t0[0] = w0[0];
      t0[1] = w0[1];
      t0[2] = w0[2];
      t0[3] = w0[3];
      t1[0] = w1[0];
      t1[1] = w1[1];
      t1[2] = w1[2];
      t1[3] = w1[3];
      t2[0] = 0;
      t2[1] = 0;
      t2[2] = 0;
      t2[3] = 0;
      t3[0] = 0;
      t3[1] = 0;
      t3[2] = 0;
      t3[3] = (salt_len_new + 40 + out_len_new) * 8;

      sha1_transform_vector (t0, t1, t2, t3, digest);
    }

    const u32x a = digest[0];
    const u32x b = digest[1];
    const u32x c = digest[2];
    const u32x d = digest[3];
    const u32x e = digest[4];

    COMPARE_M_SIMD (d, e, c, b);
  }
}

__kernel void m14400_m08 (__global pw_t *pws, __constant const kernel_rule_t *rules_buf, __global const pw_t *combs_buf, __global const bf_t *bfs_buf, __global void *tmps, __global void *hooks, __global const u32 *bitmaps_buf_s1_a, __global const u32 *bitmaps_buf_s1_b, __global const u32 *bitmaps_buf_s1_c, __global const u32 *bitmaps_buf_s1_d, __global const u32 *bitmaps_buf_s2_a, __global const u32 *bitmaps_buf_s2_b, __global const u32 *bitmaps_buf_s2_c, __global const u32 *bitmaps_buf_s2_d, __global plain_t *plains_buf, __global const digest_t *digests_buf, __global u32 *hashes_shown, __global const salt_t *salt_bufs, __global const void *esalt_bufs, __global u32 *d_return_buf, __global u32 *d_scryptV0_buf, __global u32 *d_scryptV1_buf, __global u32 *d_scryptV2_buf, __global u32 *d_scryptV3_buf, const u32 bitmap_mask, const u32 bitmap_shift1, const u32 bitmap_shift2, const u32 salt_pos, const u32 loop_pos, const u32 loop_cnt, const u32 il_cnt, const u32 digests_cnt, const u32 digests_offset, const u32 combs_mode, const u64 gid_max)
{
}

__kernel void m14400_m16 (__global pw_t *pws, __constant const kernel_rule_t *rules_buf, __global const pw_t *combs_buf, __global const bf_t *bfs_buf, __global void *tmps, __global void *hooks, __global const u32 *bitmaps_buf_s1_a, __global const u32 *bitmaps_buf_s1_b, __global const u32 *bitmaps_buf_s1_c, __global const u32 *bitmaps_buf_s1_d, __global const u32 *bitmaps_buf_s2_a, __global const u32 *bitmaps_buf_s2_b, __global const u32 *bitmaps_buf_s2_c, __global const u32 *bitmaps_buf_s2_d, __global plain_t *plains_buf, __global const digest_t *digests_buf, __global u32 *hashes_shown, __global const salt_t *salt_bufs, __global const void *esalt_bufs, __global u32 *d_return_buf, __global u32 *d_scryptV0_buf, __global u32 *d_scryptV1_buf, __global u32 *d_scryptV2_buf, __global u32 *d_scryptV3_buf, const u32 bitmap_mask, const u32 bitmap_shift1, const u32 bitmap_shift2, const u32 salt_pos, const u32 loop_pos, const u32 loop_cnt, const u32 il_cnt, const u32 digests_cnt, const u32 digests_offset, const u32 combs_mode, const u64 gid_max)
{
}

__kernel void m14400_s04 (__global pw_t *pws, __constant const kernel_rule_t *rules_buf, __global const pw_t *combs_buf, __global const bf_t *bfs_buf, __global void *tmps, __global void *hooks, __global const u32 *bitmaps_buf_s1_a, __global const u32 *bitmaps_buf_s1_b, __global const u32 *bitmaps_buf_s1_c, __global const u32 *bitmaps_buf_s1_d, __global const u32 *bitmaps_buf_s2_a, __global const u32 *bitmaps_buf_s2_b, __global const u32 *bitmaps_buf_s2_c, __global const u32 *bitmaps_buf_s2_d, __global plain_t *plains_buf, __global const digest_t *digests_buf, __global u32 *hashes_shown, __global const salt_t *salt_bufs, __global const void *esalt_bufs, __global u32 *d_return_buf, __global u32 *d_scryptV0_buf, __global u32 *d_scryptV1_buf, __global u32 *d_scryptV2_buf, __global u32 *d_scryptV3_buf, const u32 bitmap_mask, const u32 bitmap_shift1, const u32 bitmap_shift2, const u32 salt_pos, const u32 loop_pos, const u32 loop_cnt, const u32 il_cnt, const u32 digests_cnt, const u32 digests_offset, const u32 combs_mode, const u64 gid_max)
{
  /**
   * modifier
   */

  const u64 gid = get_global_id (0);
  const u64 lid = get_local_id (0);
  const u64 lsz = get_local_size (0);

  /**
   * bin2asc table
   */

  __local u32 l_bin2asc[256];

  for (u32 i = lid; i < 256; i += lsz)
  {
    const u32 i0 = (i >> 0) & 15;
    const u32 i1 = (i >> 4) & 15;

    l_bin2asc[i] = ((i0 < 10) ? '0' + i0 : 'a' - 10 + i0) << 0
                 | ((i1 < 10) ? '0' + i1 : 'a' - 10 + i1) << 8;
  }

  barrier (CLK_LOCAL_MEM_FENCE);

  if (gid >= gid_max) return;

  /**
   * base
   */

  u32 pw_buf0[4];
  u32 pw_buf1[4];

  pw_buf0[0] = pws[gid].i[0];
  pw_buf0[1] = pws[gid].i[1];
  pw_buf0[2] = pws[gid].i[2];
  pw_buf0[3] = pws[gid].i[3];
  pw_buf1[0] = pws[gid].i[4];
  pw_buf1[1] = pws[gid].i[5];
  pw_buf1[2] = pws[gid].i[6];
  pw_buf1[3] = pws[gid].i[7];

  const u32 pw_len = pws[gid].pw_len;

  /**
   * salt
   */

  const u32 dashes = 0x2d2d2d2d;

  u32 salt_buf0[4];
  u32 salt_buf1[4];
  u32 salt_buf2[4];
  u32 salt_buf3[4];

  salt_buf0[0] = salt_bufs[salt_pos].salt_buf[0];
  salt_buf0[1] = salt_bufs[salt_pos].salt_buf[1];
  salt_buf0[2] = salt_bufs[salt_pos].salt_buf[2];
  salt_buf0[3] = salt_bufs[salt_pos].salt_buf[3];
  salt_buf1[0] = salt_bufs[salt_pos].salt_buf[4];
  salt_buf1[1] = 0;
  salt_buf1[2] = 0;
  salt_buf1[3] = 0;
  salt_buf2[0] = 0;
  salt_buf2[1] = 0;
  salt_buf2[2] = 0;
  salt_buf2[3] = 0;
  salt_buf3[0] = 0;
  salt_buf3[1] = 0;
  salt_buf3[2] = 0;
  salt_buf3[3] = 0;

  shift_2 (salt_buf0, salt_buf1, salt_buf2, salt_buf3);

  salt_buf0[0] |= dashes >> 16;
  salt_buf1[1] |= dashes << 16;

  salt_buf0[0] = swap32_S (salt_buf0[0]);
  salt_buf0[1] = swap32_S (salt_buf0[1]);
  salt_buf0[2] = swap32_S (salt_buf0[2]);
  salt_buf0[3] = swap32_S (salt_buf0[3]);
  salt_buf1[0] = swap32_S (salt_buf1[0]);
  salt_buf1[1] = swap32_S (salt_buf1[1]);
  salt_buf1[2] = swap32_S (salt_buf1[2]);
  salt_buf1[3] = swap32_S (salt_buf1[3]);
  salt_buf2[0] = swap32_S (salt_buf2[0]);
  salt_buf2[1] = swap32_S (salt_buf2[1]);
  salt_buf2[2] = swap32_S (salt_buf2[2]);
  salt_buf2[3] = swap32_S (salt_buf2[3]);
  salt_buf3[0] = swap32_S (salt_buf3[0]);
  salt_buf3[1] = swap32_S (salt_buf3[1]);
  salt_buf3[2] = swap32_S (salt_buf3[2]);
  salt_buf3[3] = swap32_S (salt_buf3[3]);

  const u32 salt_len_orig = salt_bufs[salt_pos].salt_len;

  const u32 salt_len_new = 2 + salt_len_orig + 2;

  /**
   * digest
   */

  const u32 search[4] =
  {
    digests_buf[digests_offset].digest_buf[DGST_R0],
    digests_buf[digests_offset].digest_buf[DGST_R1],
    digests_buf[digests_offset].digest_buf[DGST_R2],
    digests_buf[digests_offset].digest_buf[DGST_R3]
  };

  /**
   * loop
   */

  for (u32 il_pos = 0; il_pos < il_cnt; il_pos += VECT_SIZE)
  {
    u32x w0[4] = { 0 };
    u32x w1[4] = { 0 };
    u32x w2[4] = { 0 };
    u32x w3[4] = { 0 };

    const u32x out_len_orig = apply_rules_vect (pw_buf0, pw_buf1, pw_len, rules_buf, il_pos, w0, w1);

    append_4 (out_len_orig, w0, w1, w2, w3, dashes);

    shift_2 (w0, w1, w2, w3);

    w0[0] |= dashes >> 16;

    const u32x out_len_new = 2 + out_len_orig + 4;

    append_0x80_4x4_VV (w0, w1, w2, w3, out_len_new);

    w0[0] = swap32 (w0[0]);
    w0[1] = swap32 (w0[1]);
    w0[2] = swap32 (w0[2]);
    w0[3] = swap32 (w0[3]);
    w1[0] = swap32 (w1[0]);
    w1[1] = swap32 (w1[1]);
    w1[2] = swap32 (w1[2]);
    w1[3] = swap32 (w1[3]);
    w2[0] = 0;
    w2[1] = 0;
    w2[2] = 0;
    w2[3] = 0;
    w3[0] = 0;
    w3[1] = 0;
    w3[2] = 0;
    w3[3] = 0;

    /**
     * prepend salt
     */

    const u32x out_salt_len = salt_len_new + out_len_new;

    u32x t0[4];
    u32x t1[4];
    u32x t2[4];
    u32x t3[4];

    t0[0] = salt_buf0[0];
    t0[1] = salt_buf0[1];
    t0[2] = salt_buf0[2];
    t0[3] = salt_buf0[3];
    t1[0] = salt_buf1[0];
    t1[1] = salt_buf1[1];
    t1[2] = w0[0];
    t1[3] = w0[1];
    t2[0] = w0[2];
    t2[1] = w0[3];
    t2[2] = w1[0];
    t2[3] = w1[1];
    t3[0] = w1[2];
    t3[1] = w1[3];
    t3[2] = 0;
    t3[3] = out_salt_len * 8;

    /**
     * sha1
     */

    u32x digest[5];

    digest[0] = SHA1M_A;
    digest[1] = SHA1M_B;
    digest[2] = SHA1M_C;
    digest[3] = SHA1M_D;
    digest[4] = SHA1M_E;

    sha1_transform_vector (t0, t1, t2, t3, digest);

    for (int i = 1; i < 10; i++)
    {
      u32 s[10];

      s[0] = uint_to_hex_lower8_le ((digest[0] >> 16) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[0] >> 24) & 255) << 16;
      s[1] = uint_to_hex_lower8_le ((digest[0] >>  0) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[0] >>  8) & 255) << 16;
      s[2] = uint_to_hex_lower8_le ((digest[1] >> 16) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[1] >> 24) & 255) << 16;
      s[3] = uint_to_hex_lower8_le ((digest[1] >>  0) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[1] >>  8) & 255) << 16;
      s[4] = uint_to_hex_lower8_le ((digest[2] >> 16) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[2] >> 24) & 255) << 16;
      s[5] = uint_to_hex_lower8_le ((digest[2] >>  0) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[2] >>  8) & 255) << 16;
      s[6] = uint_to_hex_lower8_le ((digest[3] >> 16) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[3] >> 24) & 255) << 16;
      s[7] = uint_to_hex_lower8_le ((digest[3] >>  0) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[3] >>  8) & 255) << 16;
      s[8] = uint_to_hex_lower8_le ((digest[4] >> 16) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[4] >> 24) & 255) << 16;
      s[9] = uint_to_hex_lower8_le ((digest[4] >>  0) & 255) <<  0
           | uint_to_hex_lower8_le ((digest[4] >>  8) & 255) << 16;

      t0[0] = salt_buf0[0];
      t0[1] = salt_buf0[1];
      t0[2] = salt_buf0[2];
      t0[3] = salt_buf0[3];
      t1[0] = salt_buf1[0];
      t1[1] = salt_buf1[1];
      t1[2] = s[0];
      t1[3] = s[1];
      t2[0] = s[2];
      t2[1] = s[3];
      t2[2] = s[4];
      t2[3] = s[5];
      t3[0] = s[6];
      t3[1] = s[7];
      t3[2] = s[8];
      t3[3] = s[9];

      digest[0] = SHA1M_A;
      digest[1] = SHA1M_B;
      digest[2] = SHA1M_C;
      digest[3] = SHA1M_D;
      digest[4] = SHA1M_E;

      sha1_transform_vector (t0, t1, t2, t3, digest);

      t0[0] = w0[0];
      t0[1] = w0[1];
      t0[2] = w0[2];
      t0[3] = w0[3];
      t1[0] = w1[0];
      t1[1] = w1[1];
      t1[2] = w1[2];
      t1[3] = w1[3];
      t2[0] = 0;
      t2[1] = 0;
      t2[2] = 0;
      t2[3] = 0;
      t3[0] = 0;
      t3[1] = 0;
      t3[2] = 0;
      t3[3] = (salt_len_new + 40 + out_len_new) * 8;

      sha1_transform_vector (t0, t1, t2, t3, digest);
    }

    const u32x a = digest[0];
    const u32x b = digest[1];
    const u32x c = digest[2];
    const u32x d = digest[3];
    const u32x e = digest[4];

    COMPARE_S_SIMD (d, e, c, b);
  }
}

__kernel void m14400_s08 (__global pw_t *pws, __constant const kernel_rule_t *rules_buf, __global const pw_t *combs_buf, __global const bf_t *bfs_buf, __global void *tmps, __global void *hooks, __global const u32 *bitmaps_buf_s1_a, __global const u32 *bitmaps_buf_s1_b, __global const u32 *bitmaps_buf_s1_c, __global const u32 *bitmaps_buf_s1_d, __global const u32 *bitmaps_buf_s2_a, __global const u32 *bitmaps_buf_s2_b, __global const u32 *bitmaps_buf_s2_c, __global const u32 *bitmaps_buf_s2_d, __global plain_t *plains_buf, __global const digest_t *digests_buf, __global u32 *hashes_shown, __global const salt_t *salt_bufs, __global const void *esalt_bufs, __global u32 *d_return_buf, __global u32 *d_scryptV0_buf, __global u32 *d_scryptV1_buf, __global u32 *d_scryptV2_buf, __global u32 *d_scryptV3_buf, const u32 bitmap_mask, const u32 bitmap_shift1, const u32 bitmap_shift2, const u32 salt_pos, const u32 loop_pos, const u32 loop_cnt, const u32 il_cnt, const u32 digests_cnt, const u32 digests_offset, const u32 combs_mode, const u64 gid_max)
{
}

__kernel void m14400_s16 (__global pw_t *pws, __constant const kernel_rule_t *rules_buf, __global const pw_t *combs_buf, __global const bf_t *bfs_buf, __global void *tmps, __global void *hooks, __global const u32 *bitmaps_buf_s1_a, __global const u32 *bitmaps_buf_s1_b, __global const u32 *bitmaps_buf_s1_c, __global const u32 *bitmaps_buf_s1_d, __global const u32 *bitmaps_buf_s2_a, __global const u32 *bitmaps_buf_s2_b, __global const u32 *bitmaps_buf_s2_c, __global const u32 *bitmaps_buf_s2_d, __global plain_t *plains_buf, __global const digest_t *digests_buf, __global u32 *hashes_shown, __global const salt_t *salt_bufs, __global const void *esalt_bufs, __global u32 *d_return_buf, __global u32 *d_scryptV0_buf, __global u32 *d_scryptV1_buf, __global u32 *d_scryptV2_buf, __global u32 *d_scryptV3_buf, const u32 bitmap_mask, const u32 bitmap_shift1, const u32 bitmap_shift2, const u32 salt_pos, const u32 loop_pos, const u32 loop_cnt, const u32 il_cnt, const u32 digests_cnt, const u32 digests_offset, const u32 combs_mode, const u64 gid_max)
{
}
