<script setup>
import { RouterLink, RouterView } from "vue-router";
import HelloWorld from "@/components/HelloWorld.vue";
import Header from "@/components/Header.vue";
import Footer from "./components/Footer.vue";
</script>

<template>
  <!-- Vanilla vue -->
  <!-- <header>
   <img alt="Vue logo" class="logo" src="@/assets/logo.svg" width="125" height="125" />

   <div class="wrapper">
      <HelloWorld msg="hello Monica!" />

      <nav>
         <RouterLink to="/" class="test">Home</RouterLink>
         <RouterLink to="/about">About</RouterLink>
      </nav>
      </div>
  </header>-->
  <!-- Vanilla vue end -->

  <!-- Header & Header Mobile -->
  <!-- Mobile header -->
  <Header />

  <!-- Page Route manager -->
  <RouterView />

  <Footer />
</template>

<style>
@import "@/assets/base.css";
@import url("https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;600;700&display=swap");

/* Custom CSS */
body {
  @apply bg-themeSecondary;
  @apply text-themePrimary;
  font-family: "Poppins", sans-serif;
}

h1,
h2,
h4 {
  @apply text-themeTertiary;
}

.router-link-active {
  @apply text-themeTertiary;
}

/* basic vite/vue css rules made when creating the app, commented out for reference purposes */
/* #app {
  max-width: 1280px;
  margin: 0 auto;
  padding: 2rem;

  font-weight: normal;
}

header {
  line-height: 1.5;
  max-height: 100vh;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

a,
.green {
  text-decoration: none;
  color: hsla(160, 100%, 37%, 1);
  transition: 0.4s;
}

@media (hover: hover) {
  a:hover {
    background-color: hsla(160, 100%, 37%, 0.2);
  }
}

nav {
  width: 100%;
  font-size: 12px;
  text-align: center;
  margin-top: 2rem;
}

nav a.router-link-exact-active {
  color: var(--color-text);
}

nav a.router-link-exact-active:hover {
  background-color: transparent;
}

nav a {
  display: inline-block;
  padding: 0 1rem;
  border-left: 1px solid var(--color-border);
}

nav a:first-of-type {
  border: 0;
}

@media (min-width: 1024px) {
  body {
    display: flex;
    place-items: center;
  }

  #app {
    display: grid;
    grid-template-columns: 1fr 1fr;
    padding: 0 2rem;
  }

  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  nav {
    text-align: left;
    margin-left: -1rem;
    font-size: 1rem;

    padding: 1rem 0;
    margin-top: 1rem;
  }
} */
</style>
