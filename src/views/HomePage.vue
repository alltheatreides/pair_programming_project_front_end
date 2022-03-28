<script setup>
import HeroSection from "@/components/HeroSection.vue";
import MktSection from "../components/MktSection.vue";
import SectionTestimonies from "../components/SectionTestimonies.vue";
</script>

<script>
export default {
   data() {
      return {
         mainKey: 0,
      };
   },
   methods: {
      // Manages the rerender with template keys
      forceRerender() {
         this.mainKey += 1;
      },
   },
   mounted() {
      this.forceRerender();
   },
};
</script>

<template>
   <main class="pt-24 md:pt-14" :key="mainKey">
      <!-- Hero section -->
      <HeroSection />

      <!-- Marketing section -->
      <MktSection />

      <!-- Testimonies section -->
      <SectionTestimonies />

      <!-- Footer section -->
   </main>
</template>
