<script setup>
import Button from "@/components/small/Button.vue";
import TestimonyCard from "./small/TestimonyCard.vue";
</script>

<template>
   <section
      class="container mx-auto px-6 md:px-10 lg:px-0 before:block before:border-b-8 before:border-themeQuaternary before:w-4/6 md:before:w-2/6 lg:before:w-1/6 before:rounded-xl before:mb-6 my-20 lg:my-40"
   >
      <h2 class="text-3xl mb-12 font-bold">Témoignages</h2>
      <TestimonyCard
         class="lg:mb-20"
         title="“Une super amélioration !”"
         description="Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolores voluptatibus soluta maxime molestiae earum perferendis quo nesciunt, at obcaecati dicta cumque nam "
         picture="/public/pictures/mpatterson.png"
      />
      <TestimonyCard
         title="“Plus besoin de whisky avant le coucher !”"
         description="Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolores voluptatibus soluta maxime molestiae earum perferendis quo nesciunt, at obcaecati dicta cumque nam "
         picture="/public/pictures/ahaddock.png"
      />
   </section>
</template>
