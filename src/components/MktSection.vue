<script setup>
import Button from '@/components/small/Button.vue';
import Card from './small/Card.vue';
// import Button from '@/components/Button.vue'
</script>

<template>
    <section
        class="before:block before:border-b-4 before:border-themeQuaternary before:w-4/6 before:rounded-xl before:mb-6 my-20"
    >
        <h2 class="text-3xl my-2">Pourquoi mesurer son sommeil ?</h2>
        <p
            class="my-2"
        >Les avantages d'une bonne nuit de sommeil sont connus de tous, mais peu de personnes dorment réellement huit heures par nuit voire plus.</p>
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
    </section>
</template>