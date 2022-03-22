<script setup>
import Form from '../components/small/Form.vue';
import FormField from '../components/small/FormField.vue';
import Button from '../components/small/Button.vue';

</script>

<template>
    <main class="pt-24 md:pt-14">
        <section
            class="container mx-auto px-6 md:px-10 lg:px-0 flex flex-col items-center min-h-[90vh]"
        >
            <Form title="Connectez vous !" buttonText="Se connecter" buttonLink="#">
                <template #field>
                    <FormField label="Nom d’utilisateur" type="text" />
                    <FormField label="Mot de passe" type="password" />
                </template>
            </Form>
        </section>
    </main>
</template>