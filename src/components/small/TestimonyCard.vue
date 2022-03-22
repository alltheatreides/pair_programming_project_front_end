<script setup>
defineProps({
   title: {
      type: String,
      required: true,
   },
   description: {
      type: String,
      required: true,
   },
   picture: {
      type: String,
      required: true,
   },
});
</script>

<template>
   <div class="card flex justify-center content-center p-10 my-6 rounded-xl">
      <figure class="grid grid-cols-3 px-4">
         <img :src="picture" :alt="picture" class="rounded-full col-span-1" />
         <figcaption class="content flex flex-col col-span-2 justify-around">
            <h3 class="font-semibold mb-6 text-lg text-center lg:text-2xl">
               {{ title }}
            </h3>
            <p
               class="text-right text-lg font-light leading-5 opacity-80 lg:text-xl"
            >
               {{ description }}
            </p>
         </figcaption>
      </figure>
   </div>
</template>

<style scope>
.card {
   background-color: rgb(63, 167, 216, 0.1);
}
</style>
