<script setup>
import Button from "./Button.vue";

defineProps({
   title: {
      type: String,
      required: true,
   },
});
</script>

<template>
   <h2 class="text-5xl font-bold text-center">{{ title }}</h2>
   <div
      class="bg-themeSecondaryDarker p-10 mt-10 rounded-xl md:w-10/12 lg:w-3/6"
   >
      <slot name="field"></slot>
   </div>
</template>
