// Returns a random number between min (inclusive) and max (exclusive)
export function randomRange(min, max) {
  return Math.random() * (max - min) + min;
}

export function scrollToSection(event, sectionId) {
  // Prevent the default anchor link behavior (instant jump)
  event.preventDefault();

  const section = document.getElementById(sectionId);

  if (section) {
    section.scrollIntoView({
      behavior: 'smooth', // Enable smooth scrolling
      block: 'start'      // Align top of section with top of viewport
    });
  } else {
    console.warn(`Scroll target not found: #${sectionId}`);
  }
}

import { writable } from 'svelte/store';

export const appState = writable({ currentVisibleSection: 'Home' });
