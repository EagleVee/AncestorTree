---
project: AncestorTree
path: CLAUDE.md
type: agent-guidelines
version: 1.5.0
updated: 2026-02-25
---

# CLAUDE.md

This file provides guidance to AI assistants (Claude, GPT, etc.) when working with code in this repository.

## Project Overview

**AncestorTree** (Gia Pha Dien Tu) is a digital family tree management system for Chi toc Dang Dinh, Thach Lam, Ha Tinh.

- **Repository:** https://github.com/Minh-Tam-Solution/AncestorTree
- **Current Version:** v1.6.0 (Sprint 8 in progress)
- **SDLC Tier:** LITE (5 stages)
- **Tech Stack:** Next.js 16, React 19, Tailwind CSS 4, Supabase
- **Built with:** [TinySDLC](https://github.com/Minh-Tam-Solution/tinysdlc) + [MTS-SDLC-Lite](https://github.com/Minh-Tam-Solution/MTS-SDLC-Lite)

## SDLC Framework v6.1.0 - LITE Tier

This project follows MTS SDLC Framework with 5 stages:

```
docs/
├── 00-foundation/     # Vision, scope, requirements, community
│   └── 06-Community/  # Community launch posts (7 platform-specific)
├── 01-planning/       # Roadmap, sprints, milestones
├── 02-design/         # Architecture, UI/UX, data models
├── 04-build/          # Implementation guidelines
└── 05-test/           # Test plans, QA
```

**DO NOT** use generic 6-stage or 11-stage SDLC structure.
**ALWAYS** use the structure defined in `.sdlc-config.json`.

## File Header Standard

All documentation files MUST include YAML front matter:

```yaml
---
project: AncestorTree
path: docs/XX-stage/filename.md
type: document-type
version: X.X.X
updated: YYYY-MM-DD
owner: team/person
status: draft|review|approved
---
```

All code files MUST include header comment:

```typescript
/**
 * @project AncestorTree
 * @file src/path/to/file.ts
 * @description Brief description
 * @version 1.0.0
 * @updated 2026-02-25
 */
```

## Project Structure

```
AncestorTree/
├── docs/                           # SDLC Documentation
│   ├── 00-foundation/              # Vision, requirements
│   │   └── 06-Community/           # Community launch posts
│   ├── 01-planning/                # Sprints, roadmap
│   ├── 02-design/                  # Architecture, UI/UX
│   ├── 04-build/                   # Implementation
│   └── 05-test/                    # Testing
├── frontend/                       # Next.js application
│   ├── src/app/                    # App router (route groups)
│   │   ├── (auth)/                 # Auth pages (login, register, forgot-password, reset-password)
│   │   └── (main)/                 # Main app with sidebar
│   │       ├── achievements/       # Vinh danh (Sprint 6)
│   │       ├── cau-duong/          # Lich Cau duong (Sprint 7)
│   │       ├── charter/            # Huong uoc (Sprint 6)
│   │       ├── contributions/      # Dong gop (Sprint 4)
│   │       ├── directory/          # Thu muc thanh vien (Sprint 4)
│   │       ├── documents/book/     # Gia pha sach (Sprint 5)
│   │       ├── events/             # Lich su kien (Sprint 4)
│   │       ├── fund/               # Quy khuyen hoc (Sprint 6)
│   │       ├── people/             # Quan ly thanh vien
│   │       ├── tree/               # Cay gia pha
│   │       └── admin/              # Admin panel
│   │           ├── achievements/   # QL Vinh danh (Sprint 6)
│   │           ├── cau-duong/      # QL Cau duong (Sprint 7)
│   │           ├── charter/        # QL Huong uoc (Sprint 6)
│   │           ├── contributions/  # QL Dong gop (Sprint 4)
│   │           ├── fund/           # QL Quy & Hoc bong (Sprint 6)
│   │           ├── settings/       # Cai dat
│   │           └── users/          # QL Nguoi dung
│   ├── src/components/             # React components
│   │   ├── ui/                     # shadcn/ui components
│   │   ├── layout/                 # Layout components (sidebar, header)
│   │   ├── home/                   # Homepage components (featured-charter)
│   │   └── people/                 # People components (person-form, family-relations-card)
│   ├── src/hooks/                  # Custom React hooks
│   │   ├── use-achievements.ts     # Achievement CRUD hooks (Sprint 6)
│   │   ├── use-cau-duong.ts        # Cau duong rotation hooks (Sprint 7)
│   │   ├── use-clan-articles.ts    # Charter CRUD hooks (Sprint 6)
│   │   ├── use-contributions.ts    # Contribution hooks (Sprint 4)
│   │   ├── use-events.ts           # Event hooks (Sprint 4)
│   │   ├── use-families.ts         # Family relations hooks (Sprint 7.5)
│   │   └── use-fund.ts             # Fund & scholarship hooks (Sprint 6)
│   ├── src/lib/                    # Utilities, Supabase client
│   │   ├── supabase.ts             # Supabase client init
│   │   ├── supabase-data.ts        # Core data layer (people, families)
│   │   ├── supabase-data-achievements.ts  # Achievement data (Sprint 6)
│   │   ├── supabase-data-cau-duong.ts     # Cau duong + DFS algorithm (Sprint 7)
│   │   ├── supabase-data-charter.ts       # Charter data (Sprint 6)
│   │   ├── supabase-data-fund.ts          # Fund & scholarship data (Sprint 6)
│   │   └── lunar-calendar.ts       # Lunar-solar conversion (Sprint 4)
│   ├── src/types/                  # TypeScript types
│   │   └── index.ts                # All type definitions
│   └── supabase/                   # Database migrations
│       ├── database-setup.sql      # Core tables (7): people, families, children, profiles, contributions, events, media
│       ├── sprint6-migration.sql   # v1.3 tables (4): achievements, fund_transactions, scholarships, clan_articles
│       └── cau-duong-migration.sql # v1.4 tables (2): cau_duong_pools, cau_duong_assignments
├── .sdlc-config.json               # SDLC configuration
├── CLAUDE.md                       # AI assistant guidelines
└── README.md                       # Project overview
```

## Database Schema

13 tables across 4 layers:

| Layer | Tables | Migration File |
|-------|--------|----------------|
| **Core Genealogy** | `people`, `families`, `children` | `database-setup.sql` |
| **Platform** | `profiles`, `contributions`, `media`, `events` | `database-setup.sql` |
| **Culture (v1.3)** | `achievements`, `fund_transactions`, `scholarships`, `clan_articles` | `sprint6-migration.sql` |
| **Ceremony (v1.4)** | `cau_duong_pools`, `cau_duong_assignments` | `cau-duong-migration.sql` |

All tables have RLS policies with 4 roles: `admin`, `editor`, `viewer`, `guest`.

## Development Commands

```bash
cd frontend

# Install dependencies
pnpm install

# Development
pnpm dev              # Start dev server (localhost:4000)

# Build & Test
pnpm build            # Production build
pnpm lint             # ESLint check
pnpm test             # Run tests (when configured)

# Type checking
pnpm tsc --noEmit     # TypeScript check

# Local development (Supabase CLI + Docker)
pnpm local:setup      # Full setup: start Docker + write .env.local
pnpm local:start      # Start containers (after first setup)
pnpm local:stop       # Stop containers (keep data)
pnpm local:reset      # Reset DB + re-seed demo data
```

See `docs/04-build/LOCAL-DEVELOPMENT.md` for full local dev guide.

## Coding Conventions

### TypeScript
- Strict mode enabled
- Use explicit types (avoid `any`)
- Prefer interfaces over types for objects

### React/Next.js
- Use functional components with hooks
- Server Components by default, `'use client'` only when needed
- Use route groups: `(auth)` for public, `(main)` for authenticated
- React Query for server state (no global client state library needed)
- Each feature module has: data layer (`src/lib/`) + hooks (`src/hooks/`) + pages (`src/app/`)

### Styling
- Tailwind CSS 4 with WindCSS
- shadcn/ui component library
- Mobile-first responsive design

### Naming
- **Files:** kebab-case (`user-profile.tsx`)
- **Components:** PascalCase (`UserProfile`)
- **Functions/vars:** camelCase (`getUserData`)
- **Constants:** SCREAMING_SNAKE (`MAX_RETRY_COUNT`)
- **Data layer files:** `supabase-data-{module}.ts`
- **Hook files:** `use-{module}.ts`

## Git Workflow

### Commit Messages
Follow Conventional Commits:
```
feat: add family tree visualization
fix: resolve date picker timezone issue
docs: update API documentation
chore: upgrade dependencies
```

### Branch Naming
```
feature/tree-visualization
fix/auth-session-bug
docs/api-reference
chore/upgrade-deps
```

## Key Files Reference

| Purpose | Location |
|---------|----------|
| SDLC Config | `.sdlc-config.json` |
| Vision & Scope | `docs/00-foundation/VISION.md` |
| Business Requirements | `docs/01-planning/BRD.md` |
| Technical Design | `docs/02-design/technical-design.md` |
| UI/UX Design | `docs/02-design/ui-ux-design.md` |
| Core DB Schema | `frontend/supabase/database-setup.sql` |
| Sprint 6 Migration | `frontend/supabase/sprint6-migration.sql` |
| Sprint 7 Migration | `frontend/supabase/cau-duong-migration.sql` |
| Sprint Plan | `docs/04-build/SPRINT-PLAN.md` |
| Test Plan | `docs/05-test/TEST-PLAN.md` |
| Community Launch | `docs/00-foundation/06-Community/Community-Launch-Strategy.md` |

## Common Tasks

### Adding a New Page
1. Create page in appropriate route group (`(auth)` or `(main)`)
2. Add error.tsx and loading.tsx boundaries
3. Add navigation link in `app-sidebar.tsx` if needed
4. Update `docs/02-design/ui-ux-design.md`

### Adding a Database Table
1. For core tables: add SQL to `frontend/supabase/database-setup.sql`
2. For feature tables: create separate migration file (e.g., `sprint6-migration.sql`)
3. Add RLS policies in the same migration file
4. Update types in `src/types/index.ts`
5. Create data layer in `src/lib/supabase-data-{module}.ts`
6. Create hooks in `src/hooks/use-{module}.ts`
7. Update `docs/02-design/technical-design.md`

### Adding a Feature Module (Sprint 6 Pattern)
1. **Types:** Add interfaces to `src/types/index.ts`
2. **Data layer:** Create `src/lib/supabase-data-{module}.ts` with CRUD functions
3. **Hooks:** Create `src/hooks/use-{module}.ts` with React Query hooks
4. **Public page:** Create `src/app/(main)/{module}/page.tsx` + error.tsx + loading.tsx
5. **Admin page:** Create `src/app/(main)/admin/{module}/page.tsx`
6. **Navigation:** Add items to `src/components/layout/app-sidebar.tsx`

### Adding a Component
1. Create in appropriate folder under `src/components/`
2. Use shadcn/ui primitives when possible

## Notes for AI Assistants

- Always check `.sdlc-config.json` for project tier and stages
- Include proper file headers when creating/modifying files
- Follow existing code patterns in the codebase (especially Sprint 6 module pattern)
- Run `pnpm build` to verify changes compile
- Update relevant documentation when making changes
- Use Vietnamese for user-facing content, English for code/comments
- Data layer functions return typed results using Supabase client
- React Query hooks handle caching, invalidation, and optimistic updates
- Admin pages require editor role guard
- All pages should have error.tsx and loading.tsx boundaries
