<script setup>


defineProps({

    label: {
        type: String,
        required: true
    },
    type: {
        type: String,
        required: true
    }
})
</script>

<template>
    <div class="flex flex-col my-4">
        <label>{{ label }}</label>
        <input :type="type" />
    </div>
</template>