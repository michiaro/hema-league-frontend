<script setup lang="ts">
import MainScreen from './components/MainScreen.vue'
import Features from './components/Features.vue'
import News from './components/News.vue'
import Schedule from './components/Schedule.vue'
import Footer from './components/Footer.vue'
</script>

<template>
  <main class="main">
    <MainScreen />

    <Features />

    <News />

    <Schedule />

    <Footer />
  </main>
</template>

<style scoped>
@media (min-width: 1024px) {
}
</style>
