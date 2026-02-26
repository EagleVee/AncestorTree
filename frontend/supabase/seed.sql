-- ═══════════════════════════════════════════════════════════════════════════
-- AncestorTree — Seed Data for Local Development
-- Chạy tự động sau migrations khi `supabase start` hoặc `supabase db reset`
-- ═══════════════════════════════════════════════════════════════════════════

-- ─── Auth Users ──────────────────────────────────────────────────────────
-- Tạo 2 demo accounts (chỉ hoạt động trên Supabase local)

-- Admin account: admin@giapha.local / admin123
INSERT INTO auth.users (
    id, instance_id, email, encrypted_password,
    email_confirmed_at, created_at, updated_at,
    raw_user_meta_data, raw_app_meta_data,
    confirmation_token, aud, role,
    is_super_admin
) VALUES (
    'aaaaaaaa-0001-4000-a000-000000000001',
    '00000000-0000-0000-0000-000000000000',
    'admin@giapha.local',
    crypt('admin123', gen_salt('bf')),
    NOW(), NOW(), NOW(),
    '{"full_name": "Quản trị viên"}'::jsonb,
    '{"provider": "email", "providers": ["email"]}'::jsonb,
    '', 'authenticated', 'authenticated',
    false
);

INSERT INTO auth.identities (
    id, user_id, identity_data, provider, provider_id,
    created_at, updated_at, last_sign_in_at
) VALUES (
    'aaaaaaaa-0001-4000-a000-000000000001',
    'aaaaaaaa-0001-4000-a000-000000000001',
    '{"sub": "aaaaaaaa-0001-4000-a000-000000000001", "email": "admin@giapha.local"}'::jsonb,
    'email',
    'aaaaaaaa-0001-4000-a000-000000000001',
    NOW(), NOW(), NOW()
);

-- Viewer account: viewer@giapha.local / viewer123
INSERT INTO auth.users (
    id, instance_id, email, encrypted_password,
    email_confirmed_at, created_at, updated_at,
    raw_user_meta_data, raw_app_meta_data,
    confirmation_token, aud, role,
    is_super_admin
) VALUES (
    'aaaaaaaa-0002-4000-a000-000000000002',
    '00000000-0000-0000-0000-000000000000',
    'viewer@giapha.local',
    crypt('viewer123', gen_salt('bf')),
    NOW(), NOW(), NOW(),
    '{"full_name": "Người xem"}'::jsonb,
    '{"provider": "email", "providers": ["email"]}'::jsonb,
    '', 'authenticated', 'authenticated',
    false
);

INSERT INTO auth.identities (
    id, user_id, identity_data, provider, provider_id,
    created_at, updated_at, last_sign_in_at
) VALUES (
    'aaaaaaaa-0002-4000-a000-000000000002',
    'aaaaaaaa-0002-4000-a000-000000000002',
    '{"sub": "aaaaaaaa-0002-4000-a000-000000000002", "email": "viewer@giapha.local"}'::jsonb,
    'email',
    'aaaaaaaa-0002-4000-a000-000000000002',
    NOW(), NOW(), NOW()
);

-- GoTrue expects string columns in auth.users to be '' not NULL (avoids "converting NULL to string" on login).
-- Update all nullable string columns (except email, encrypted_password) so any schema version works.
DO $$
DECLARE
  r RECORD;
  q TEXT;
BEGIN
  FOR r IN
    SELECT column_name
    FROM information_schema.columns
    WHERE table_schema = 'auth' AND table_name = 'users'
      AND data_type IN ('character varying', 'text', 'character')
      AND is_nullable = 'YES'
      AND column_name NOT IN ('email', 'encrypted_password', 'phone')
  LOOP
    q := format('UPDATE auth.users SET %I = '''' WHERE %I IS NULL', r.column_name, r.column_name);
    EXECUTE q;
  END LOOP;
END $$;

-- handle_new_user trigger sẽ tự tạo profiles, sau đó promote admin
UPDATE public.profiles SET role = 'admin' WHERE user_id = 'aaaaaaaa-0001-4000-a000-000000000001';

-- ─── People (Họ Nguyễn làng Yên Cát — theo sơ đồ gia phả) ─────────────────

-- Đời 1: Cụ Tổ Chi
INSERT INTO public.people (id, handle, display_name, gender, generation, is_living, birth_year, death_year, death_lunar, biography, privacy_level) VALUES
('bbbbbbbb-0001-4000-b000-000000000001', 'P001', 'Nguyễn Quý Duy', 1, 1, false, NULL, NULL, NULL, 'Cụ Tổ Chi — Họ Nguyễn làng Yên Cát.', 0);

-- Đời 2: Con Cụ Tổ Chi
INSERT INTO public.people (id, handle, display_name, gender, generation, is_living, birth_year, death_year, death_lunar, biography, privacy_level) VALUES
('bbbbbbbb-0002-4000-b000-000000000002', 'P002', 'Nguyễn Văn Thành', 1, 2, false, NULL, NULL, NULL, 'Cụ Trưởng (1).', 0),
('bbbbbbbb-0003-4000-b000-000000000003', 'P003', 'Nguyễn Thành Đô', 1, 2, false, NULL, NULL, NULL, 'Cụ (2).', 0);

-- Đời 3
INSERT INTO public.people (id, handle, display_name, gender, generation, is_living, birth_year, death_year, death_lunar, biography, privacy_level) VALUES
('bbbbbbbb-0004-4000-b000-000000000004', 'P004', 'Nguyễn Văn Tạo', 1, 3, false, NULL, NULL, NULL, 'Cụ — con Cụ Trưởng Nguyễn Văn Thành.', 0),
('bbbbbbbb-0005-4000-b000-000000000005', 'P005', 'Nguyễn Văn Môn', 1, 3, false, NULL, NULL, NULL, 'Cụ (1) — con Cụ Nguyễn Thành Đô.', 0),
('bbbbbbbb-0006-4000-b000-000000000006', 'P006', 'Nguyễn Văn Hạp', 1, 3, false, NULL, NULL, NULL, 'Cụ (2) — con Cụ Nguyễn Thành Đô.', 0),
('bbbbbbbb-0007-4000-b000-000000000007', 'P007', 'Nguyễn Văn Úc', 1, 3, false, NULL, NULL, NULL, 'Cụ (3) — con Cụ Nguyễn Thành Đô.', 0),
('bbbbbbbb-0008-4000-b000-000000000008', 'P008', 'Nguyễn Như Chương', 1, 3, false, NULL, NULL, NULL, 'Cụ (4) — con Cụ Nguyễn Thành Đô.', 0);

-- Đời 4
INSERT INTO public.people (id, handle, display_name, gender, generation, is_living, birth_year, death_year, death_lunar, biography, privacy_level) VALUES
('bbbbbbbb-0009-4000-b000-000000000009', 'P009', 'Nguyễn Văn Tốn', 1, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Văn Tạo.', 0),
('bbbbbbbb-0010-4000-b000-000000000010', 'P010', 'Nguyễn Thị Hài', 2, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Văn Tạo.', 0),
('bbbbbbbb-0011-4000-b000-000000000011', 'P011', 'Nguyễn Thị Gái', 2, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Văn Môn.', 0),
('bbbbbbbb-0012-4000-b000-000000000012', 'P012', 'Nguyễn Thị Chăm', 2, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Văn Hạp.', 0),
('bbbbbbbb-0013-4000-b000-000000000013', 'P013', 'Nguyễn Văn Ngự', 1, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Văn Hạp.', 0),
('bbbbbbbb-0014-4000-b000-000000000014', 'P014', 'Nguyễn Thị Nhị (Đoán)', 2, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Văn Hạp.', 0),
('bbbbbbbb-0015-4000-b000-000000000015', 'P015', 'Cụ Tiết (hay Cụ Phó Hội)', 1, 4, false, NULL, NULL, NULL, 'Cụ Tiết / Cụ Phó Hội — con Cụ Nguyễn Văn Úc.', 0),
('bbbbbbbb-0016-4000-b000-000000000016', 'P016', 'Nguyễn Văn Bảng', 1, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Như Chương.', 0),
('bbbbbbbb-0017-4000-b000-000000000017', 'P017', 'Nguyễn Văn Đảm', 1, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Như Chương.', 0),
('bbbbbbbb-0018-4000-b000-000000000018', 'P018', 'Nguyễn Thị Phê', 2, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Như Chương.', 0),
('bbbbbbbb-0019-4000-b000-000000000019', 'P019', 'Nguyễn Thị Hữu', 2, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Như Chương.', 0),
('bbbbbbbb-0020-4000-b000-000000000020', 'P020', 'Nguyễn Thị Xã', 2, 4, false, NULL, NULL, NULL, 'Cụ — con Cụ Nguyễn Như Chương.', 0);

-- ─── Families ─────────────────────────────────────────────────────────────

INSERT INTO public.families (id, handle, father_id, mother_id, marriage_date, sort_order) VALUES
('cccccccc-0001-4000-c000-000000000001', 'F001', 'bbbbbbbb-0001-4000-b000-000000000001', NULL, NULL, 1),
('cccccccc-0002-4000-c000-000000000002', 'F002', 'bbbbbbbb-0002-4000-b000-000000000002', NULL, NULL, 1),
('cccccccc-0003-4000-c000-000000000003', 'F003', 'bbbbbbbb-0004-4000-b000-000000000004', NULL, NULL, 1),
('cccccccc-0004-4000-c000-000000000004', 'F004', 'bbbbbbbb-0003-4000-b000-000000000003', NULL, NULL, 1),
('cccccccc-0005-4000-c000-000000000005', 'F005', 'bbbbbbbb-0005-4000-b000-000000000005', NULL, NULL, 1),
('cccccccc-0006-4000-c000-000000000006', 'F006', 'bbbbbbbb-0006-4000-b000-000000000006', NULL, NULL, 1),
('cccccccc-0007-4000-c000-000000000007', 'F007', 'bbbbbbbb-0007-4000-b000-000000000007', NULL, NULL, 1),
('cccccccc-0008-4000-c000-000000000008', 'F008', 'bbbbbbbb-0008-4000-b000-000000000008', NULL, NULL, 1);

-- ─── Children ─────────────────────────────────────────────────────────────

INSERT INTO public.children (family_id, person_id, sort_order) VALUES
-- Cụ Tổ Chi -> (1) Cụ Trưởng, (2) Cụ Thành Đô
('cccccccc-0001-4000-c000-000000000001', 'bbbbbbbb-0002-4000-b000-000000000002', 1),
('cccccccc-0001-4000-c000-000000000001', 'bbbbbbbb-0003-4000-b000-000000000003', 2),
-- Cụ Trưởng Nguyễn Văn Thành -> Cụ Nguyễn Văn Tạo
('cccccccc-0002-4000-c000-000000000002', 'bbbbbbbb-0004-4000-b000-000000000004', 1),
-- Cụ Nguyễn Văn Tạo -> Cụ Tốn, Cụ Thị Hài
('cccccccc-0003-4000-c000-000000000003', 'bbbbbbbb-0009-4000-b000-000000000009', 1),
('cccccccc-0003-4000-c000-000000000003', 'bbbbbbbb-0010-4000-b000-000000000010', 2),
-- Cụ Thành Đô -> (1) Môn, (2) Hạp, (3) Úc, (4) Như Chương
('cccccccc-0004-4000-c000-000000000004', 'bbbbbbbb-0005-4000-b000-000000000005', 1),
('cccccccc-0004-4000-c000-000000000004', 'bbbbbbbb-0006-4000-b000-000000000006', 2),
('cccccccc-0004-4000-c000-000000000004', 'bbbbbbbb-0007-4000-b000-000000000007', 3),
('cccccccc-0004-4000-c000-000000000004', 'bbbbbbbb-0008-4000-b000-000000000008', 4),
-- Cụ Nguyễn Văn Môn -> Cụ Thị Gái
('cccccccc-0005-4000-c000-000000000005', 'bbbbbbbb-0011-4000-b000-000000000011', 1),
-- Cụ Nguyễn Văn Hạp -> Chăm, Ngự, Nhị (Đoán)
('cccccccc-0006-4000-c000-000000000006', 'bbbbbbbb-0012-4000-b000-000000000012', 1),
('cccccccc-0006-4000-c000-000000000006', 'bbbbbbbb-0013-4000-b000-000000000013', 2),
('cccccccc-0006-4000-c000-000000000006', 'bbbbbbbb-0014-4000-b000-000000000014', 3),
-- Cụ Nguyễn Văn Úc -> Cụ Tiết (Cụ Phó Hội)
('cccccccc-0007-4000-c000-000000000007', 'bbbbbbbb-0015-4000-b000-000000000015', 1),
-- Cụ Nguyễn Như Chương -> Bảng, Đảm, Phê, Hữu, Xã
('cccccccc-0008-4000-c000-000000000008', 'bbbbbbbb-0016-4000-b000-000000000016', 1),
('cccccccc-0008-4000-c000-000000000008', 'bbbbbbbb-0017-4000-b000-000000000017', 2),
('cccccccc-0008-4000-c000-000000000008', 'bbbbbbbb-0018-4000-b000-000000000018', 3),
('cccccccc-0008-4000-c000-000000000008', 'bbbbbbbb-0019-4000-b000-000000000019', 4),
('cccccccc-0008-4000-c000-000000000008', 'bbbbbbbb-0020-4000-b000-000000000020', 5);

-- ─── Events (Ngày giỗ) ───────────────────────────────────────────────────

INSERT INTO public.events (title, event_type, event_lunar, person_id, recurring, location) VALUES
('Giỗ Cụ Tổ Chi Nguyễn Quý Duy', 'gio', NULL, 'bbbbbbbb-0001-4000-b000-000000000001', true, 'Nhà thờ họ'),
('Rằm tháng Bảy', 'le_tet', '15/7', NULL, true, 'Nhà thờ họ'),
('Tết Nguyên Đán', 'le_tet', '1/1', NULL, true, 'Nhà thờ họ');

-- ─── Achievements ─────────────────────────────────────────────────────────
-- (Thêm sau khi có thành viên phù hợp trong cây gia phả)

-- ─── Clan Articles (Hương ước) ────────────────────────────────────────────

INSERT INTO public.clan_articles (title, content, category, sort_order) VALUES
('Gia huấn dòng họ', 'Kính trên nhường dưới, giữ gìn nề nếp gia phong. Con cháu phải siêng năng học hành, hiếu thảo với cha mẹ.', 'gia_huan', 1),
('Quy ước họp họ', 'Họp họ tổ chức vào ngày Rằm tháng Giêng hàng năm tại nhà thờ họ. Mọi thành viên từ 18 tuổi trở lên đều có quyền tham dự và biểu quyết.', 'quy_uoc', 1);

-- ═══════════════════════════════════════════════════════════════════════════
-- DONE — Login: admin@giapha.local / admin123
-- ═══════════════════════════════════════════════════════════════════════════
