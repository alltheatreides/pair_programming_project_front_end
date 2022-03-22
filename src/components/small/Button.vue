<script setup>
defineProps({
   text: {
      type: String,
      required: true,
   },
   link: {
      type: String,
      required: false,
   },
});
</script>

<template>
   <a :href="link" target="_blank">
      <button
         class="px-6 py-3 bg-themeQuaternary rounded-xl w-fit text-white mt-12 flex items-center space-x-3"
      >
         <span class="text-lg font-bold">{{ text }}</span>
         <slot name="svg"></slot>
      </button>
   </a>
</template>
