# Leif Adamec Rydenfalk - Personal Portfolio Website

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) 

This repository contains the source code for my personal portfolio website, built with SvelteKit, TypeScript, and Tailwind CSS. It showcases my skills, projects, professional experience, and provides ways to get in touch.

**Visit the live site:** [adamec.me](https://adamec.me/) 

---

## ✨ Features

*   **Modern Tech Stack:** Built with the latest SvelteKit, leveraging Vite for lightning-fast HMR.
*   **Type Safety:** Written entirely in TypeScript for enhanced code quality and maintainability.
*   **Component-Based:** Uses Svelte components for modularity and reusability (`Project`, `TitleCard`, `Text`, etc.).
*   **Responsive Design:** Styled with Tailwind CSS for a clean look that adapts seamlessly across devices.
*   **Dark Mode:** Includes support for user-preferred color schemes.
*   **Smooth Scrolling & Navigation:** Easy navigation between sections.
*   **Dynamic Content:** Data for Experience, Projects, and Skills is managed centrally and rendered dynamically.
*   **Subtle Animations:** Uses custom components (`Show`) for smooth element loading animations.
*   **Comprehensive Sections:** Includes Home, About Me, Skills (detailed breakdown), Experience, Projects, and Contact sections.

## 🛠 Tech Stack

*   **Framework:** [SvelteKit](https://kit.svelte.dev/)
*   **Language:** [TypeScript](https://www.typescriptlang.org/)
*   **Styling:** [Tailwind CSS](https://tailwindcss.com/)
*   **Development Server:** [Vite](https://vitejs.dev/)
*   **Deployment:** [Cloudflare](https://www.cloudflare.com/)

## 🚀 Getting Started

Follow these instructions to get a local copy up and running for development purposes.

### Prerequisites

*   Node.js (v18 or later recommended)
*   yarn (or pnpm/npm)

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Leif-Rydenfalk/portfolio.git 
    cd adamec_svelte_tailwind #
    ```

2.  **Install dependencies:**
    ```bash
    yarn install
    # or
    # pnpm install
    # or
    # npm install
    ```

### Running Locally

1.  **Start the development server:**
    ```bash
    yarn dev
    # or
    # pnpm dev
    # or
    # npm run dev
    ```

2.  Open your browser and navigate to `http://localhost:5173` (or the port specified in your terminal).

## 📦 Building for Production

To create a production-ready version of the site:

```bash
yarn build
# or
# pnpm build
# or
# npm run build
```

This will generate the static files or server output (depending on your SvelteKit adapter) in the designated build directory (e.g., `build/` or `.svelte-kit/output/`). You can then deploy these files to your hosting provider. Refer to the [SvelteKit adapters documentation](https://kit.svelte.dev/docs/adapters) for more details specific to your deployment target.

## 📁 Project Structure (Simplified)

```
/
├── static/             # Static assets (images, favicons)
│
├── src/
│   ├── lib/            # Reusable Svelte components, utilities, data
│   │   ├── components/ # (If you structure components further)
│   │   ├── util/       # Utility functions (e.g., scrolling)
│   │   ├── Project.svelte
│   │   ├── Text.svelte
│   │   └── ... (other components/data files)
│   │
│   ├── routes/         # SvelteKit file-based routing
│   │   └── +page.svelte # Main page component loading all sections
│   │   └── +layout.svelte # Optional root layout
│   │
│   └── app.d.ts        # TypeScript definitions
│   └── app.html        # HTML template shell
│
├── package.json        # Project dependencies and scripts
├── svelte.config.js    # SvelteKit configuration
├── tailwind.config.js  # Tailwind CSS configuration
├── vite.config.ts      # Vite configuration
└── README.md           # This file
```

## 🙏 Contributing

This is primarily a personal project showcasing my own work. While contributions aren't actively solicited, feel free to open an issue if you spot a bug or have a suggestion.

## 📄 License

This project is licensed under the MIT License - see the `LICENSE` file for details.

---
