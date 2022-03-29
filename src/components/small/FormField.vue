<script setup>
defineProps({
   label: {
      type: String,
      required: true,
   },
   type: {
      type: String,
      required: true,
   },
});
</script>
<script>
export default {
   props: ["modelValue"],
   emits: ["update:modelValue"],
};
</script>

<template>
   <div class="flex flex-col">
      <label class="mb-4 text-base lg:text-xl">{{ label }}</label>
      <input
         :type="type"
         class="text-themeSecondary h-12 md:h-14 lg:h-16 rounded-xl px-4"
         :value="modelValue"
         @input="$emit('update:modelValue', $event.target.value)"
      />
   </div>
</template>
