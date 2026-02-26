# AncestorTree

> **Gia Pha Dien Tu - Họ Đặng làng Kỷ Các, Thach Lam, Ha Tinh**

Phan mem quan ly gia pha dien tu giup gin giu va truyen thua thong tin dong ho qua cac the he.

*"Gin giu tinh hoa - Tiep buoc cha ong"*

## Tinh nang

### Core (v1.0)
- **Cay gia pha truc quan** - So do pha he tuong tac, zoom, pan, collapse/expand, 10+ doi
- **Quan ly thanh vien** - Ho so ca nhan chi tiet (30+ truong thong tin)
- **Phan quyen 4 cap** - Admin, Editor, Viewer, Guest (Supabase RLS)
- **Tim kiem** - Tra cuu nhanh theo ten, doi, chi nhanh
- **Admin Panel** - Quan ly nguoi dung, du lieu
- **Responsive** - Tuong thich mobile/tablet/desktop

### Vietnamese Cultural (v1.1-v1.3)
- **Lich am duong** - Chuyen doi chinh xac, hien thi ngay gio
- **Chi/nhanh** - Quan ly theo cau truc dong ho Viet Nam
- **Doi (Generation)** - Tinh tu dong theo pha he
- **Can chi** - Giap Ty, At Suu, ...
- **Vinh danh thanh tich** - Bang vinh danh thanh vien xuat sac (hoc tap, su nghiep, cong hien)
- **Quy khuyen hoc** - Quan ly quy, hoc bong, khen thuong, theo doi thu chi
- **Huong uoc gia toc** - Gia huan, quy uoc, loi dan con chau
- **Thu muc thanh vien** - Danh ba lien lac voi quyen rieng tu
- **Lich su kien** - Theo doi ngay gio, le tet

### Ceremony & Relations (v1.4-v1.5)
- **Cau duong** - Phan cong trach nhiem cau duong theo lich am (thuat toan DFS)
- **Quan he gia dinh** - Hien thi bo/me/anh-chi-em/vo-chong/con theo giao dien truc quan
- **Them thanh vien co quan he** - Chon bo/me khi tao moi, them con vao gia dinh
- **Cay loc theo goc** - Hien thi cay gia pha bat dau tu bat ky thanh vien nao

## Tech Stack

| Layer | Technology |
|-------|------------|
| Frontend | Next.js 16, React 19, TypeScript 5 |
| Styling | Tailwind CSS 4, shadcn/ui, Radix UI |
| Database | Supabase (PostgreSQL, Auth, Storage, RLS) |
| State | React Query (TanStack Query) |
| Deployment | Vercel + Supabase Cloud |
| Cost | **$0/thang** (100% free tier) |

## Quick Start

### Option A: Local Development (no cloud account needed)

> Requires Docker Desktop + Supabase CLI

```bash
git clone https://github.com/Minh-Tam-Solution/AncestorTree.git
cd AncestorTree/frontend
pnpm install
pnpm local:setup   # starts Docker, runs migrations, writes .env.local
pnpm dev
```

Open [http://localhost:4000](http://localhost:4000)

Demo login: `admin@giapha.local` / `admin123`

See [docs/04-build/LOCAL-DEVELOPMENT.md](./docs/04-build/LOCAL-DEVELOPMENT.md) for full guide.

### Option B: Supabase Cloud

```bash
git clone https://github.com/Minh-Tam-Solution/AncestorTree.git
cd AncestorTree/frontend
pnpm install
cp .env.local.example .env.local
# Fill in NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY
# Then run migrations in Supabase SQL Editor (supabase/migrations/ in order)
pnpm dev
```

Open [http://localhost:4000](http://localhost:4000)

## Project Structure

```
AncestorTree/
├── docs/                           # SDLC Documentation (LITE tier)
│   ├── 00-foundation/              # Vision, requirements, community
│   │   └── 06-Community/           # Community launch posts
│   ├── 01-planning/                # BRD, roadmap
│   ├── 02-design/                  # Architecture, UI/UX
│   ├── 04-build/                   # Sprint plans
│   └── 05-test/                    # Test plans
├── frontend/                       # Next.js application
│   ├── src/
│   │   ├── app/                    # App router (route groups)
│   │   │   ├── (auth)/             # Login, register
│   │   │   └── (main)/             # Main app with sidebar
│   │   │       ├── achievements/   # Vinh danh
│   │   │       ├── charter/        # Huong uoc
│   │   │       ├── contributions/  # Dong gop
│   │   │       ├── directory/      # Thu muc thanh vien
│   │   │       ├── events/         # Lich su kien
│   │   │       ├── fund/           # Quy khuyen hoc
│   │   │       ├── people/         # Quan ly thanh vien
│   │   │       ├── tree/           # Cay gia pha
│   │   │       └── admin/          # Admin panel
│   │   ├── components/             # React components
│   │   │   ├── ui/                 # shadcn/ui
│   │   │   └── layout/            # Layout (sidebar, header)
│   │   ├── hooks/                  # Custom React hooks
│   │   ├── lib/                    # Supabase client, data layer
│   │   └── types/                  # TypeScript types
│   └── supabase/                   # Database migrations
│       ├── database-setup.sql      # Core tables (7)
│       ├── sprint6-migration.sql   # v1.3 tables (4)
│       └── cau-duong-migration.sql # v1.4 tables (2)
├── .sdlc-config.json               # SDLC configuration
├── CLAUDE.md                       # AI assistant guidelines
└── README.md
```

## Database

13 tables across 4 layers:

| Layer | Tables | Description |
|-------|--------|-------------|
| Core Genealogy | `people`, `families`, `children` | Pha he, quan he gia dinh |
| Platform | `profiles`, `contributions`, `media`, `events` | Tai khoan, dong gop, su kien |
| Culture (v1.3) | `achievements`, `fund_transactions`, `scholarships`, `clan_articles` | Vinh danh, quy, huong uoc |
| Ceremony (v1.4) | `cau_duong_pools`, `cau_duong_assignments` | Phan cong cau duong le tet |

All tables have Row Level Security (RLS) policies with 4 roles.

## Documentation

Full SDLC documentation (9 docs, 141KB):

| Stage | Documents |
|-------|-----------|
| 00-Foundation | Vision, Problem Statement, Market Research, Business Case |
| 01-Planning | BRD (77 FRs + 17 NFRs), Roadmap |
| 02-Design | Technical Design (13 tables), UI/UX Design |
| 04-Build | Sprint Plan (7.5 sprints) |

See [docs/README.md](./docs/README.md) for full documentation index.

## Roadmap

```
v0.1.0 Alpha    [##########] Done - Infrastructure + Auth
v1.0.0 MVP      [##########] Done - Tree + CRUD + Admin + Deploy
v1.1.0 Enhanced [##########] Done - Directory + Calendar + Contributions
v1.2.0 Release  [##########] Done - GEDCOM + Book Generator + Photos
v1.3.0 Culture  [##########] Done - Vinh danh + Quy khuyen hoc + Huong uoc
v1.4.0 Ceremony [##########] Done - Cau duong rotation + DFS algorithm
v1.5.0 Relations[##########] Done - Family relations UX + tree filter by root
v1.6.0 LocalDev [#########-] In Progress - Supabase CLI + Docker local mode
v2.0.0 Community [----------] Future - Nha tho ho, Notifications, Cross-clan
```

## For Your Own Clan

AncestorTree is designed to be **forked and customized**. Any Vietnamese family can:

1. Fork this repo
2. Create a free Supabase project
3. Run the database setup SQL
4. Deploy to Vercel (free)
5. Start entering family data

Total setup time: ~30 minutes. Total cost: $0/month.

## Built With

This project was built using [TinySDLC](https://github.com/Minh-Tam-Solution/tinysdlc) agent orchestrator following [MTS-SDLC-Lite](https://github.com/Minh-Tam-Solution/MTS-SDLC-Lite) methodology.

## Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'feat: add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

MIT License - see [LICENSE](./LICENSE) for details.
