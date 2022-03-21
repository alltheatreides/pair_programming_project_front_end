<script setup>
import Button from "@/components/small/Button.vue";
import Card from "./small/Card.vue";
// import Button from '@/components/Button.vue'
</script>

<template>
   <section
      class="container mx-auto px-6 md:px-10 lg:px-0 before:block before:border-b-8 before:border-themeQuaternary before:w-4/6 md:before:w-2/6 lg:before:w-1/6 before:rounded-xl before:mb-6 mb-24 md:mt-20"
   >
      <article class="flex flex-col lg:flex-row">
         <div class="w-3/6">
            <h2
               class="text-3xl mb-6 font-bold md:w-5/12 leading-relaxed"
            >Pourquoi mesurer son sommeil ?</h2>

            <p class="my-2 mt-4 lg:w-5/6">
               Les avantages d'une bonne nuit de sommeil sont connus de tous, mais peu
               de personnes dorment réellement huit heures par nuit voire plus.
            </p>
            <div
               class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-1 lg:w-3/6 mt-6 gap-4 lg:gap-10"
            >
               <Card
                  title="Améliorer la qualité du sommeil."
                  description="Lorem ipsum dolor sit amet consectetur adipisicing elit."
               />
               <Card
                  title="Améliorer la qualité du sommeil."
                  description="Lorem ipsum dolor sit amet consectetur adipisicing elit."
               />
               <Card
                  title="Améliorer la qualité du sommeil."
                  description="Lorem ipsum dolor sit amet consectetur adipisicing elit."
               />
            </div>
         </div>

         <img
            class="mt-8 w-3/6"
            src="/public/pictures/sleep2.jpg"
            alt="Photo by Lux Graves on Unsplash"
         />
      </article>
   </section>
</template>
