<script setup>
import Form from "../components/small/Form.vue";
import FormField from "../components/small/FormField.vue";
import Button from "../components/small/Button.vue";
</script>
<script>
export default {
   data() {
      return {};
   },
   methods: {
      test() {
         console.log(this.user_name_input);
         console.log(this.user_email_input);
         console.log(this.user_password_input);
         const what = JSON.stringify({
            user_name: this.user_name_input,
            user_email: this.user_email_input,
            user_password: this.user_password_input,
         });
         console.log(what);
      },
      async register() {
         const rest = "http://127.0.0.1:8000";
         try {
            const response = await fetch(`${rest}/api/register`, {
               method: "POST",
               headers: {
                  "Content-Type": "application/json",
               },
               body: JSON.stringify({
                  // user_name: "UserTest2",
                  // user_email: "UserTest2",
                  // user_password: "this.user_password_input",
                  user_name: this.user_name_input,
                  user_email: this.user_email_input,
                  user_password: this.user_password_input,
               }),
            });
            const data = await response.json();
            console.log(data);
         } catch (error) {
            console.log(error);
         }
      },
   },
};
</script>

<template>
   <main class="pt-24 md:pt-14">
      <section
         class="container mx-auto px-6 md:px-10 lg:px-0 flex flex-col items-center min-h-[90vh]"
      >
         <Form title="Inscrivez vous !" buttonText="S'inscrire" buttonLink="#">
            <template #field>
               <FormField
                  label="Nom d’utilisateur"
                  type="text"
                  :modelValue="user_name_input"
                  @update:modelValue="
                     (newValue) => (user_name_input = newValue)
                  "
               />
               <FormField
                  label="Email"
                  type="text"
                  v-model="text"
                  :modelValue="user_email_input"
                  @update:modelValue="
                     (newValue) => (user_email_input = newValue)
                  "
               />
               <FormField
                  label="Mot de passe"
                  type="password"
                  :modelValue="user_password_input"
                  @update:modelValue="
                     (newValue) => (user_password_input = newValue)
                  "
               />
               <Button @click="register" text="S'inscrire">
                  <template #svg>
                     <svg
                        width="30"
                        height="30"
                        viewBox="0 0 37 37"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                     >
                        <path
                           d="M28.7783 16.952C29.6886 16.6107 30.523 16.0417 31.2432 15.3214C34.0875 12.4771 34.0875 7.85036 31.2432 5.00607C28.3989 2.16177 23.7722 2.16177 20.9279 5.00607C20.2832 5.65074 19.7901 6.37133 19.4489 7.12974L16.1115 8.2294C16.4909 6.29534 17.4009 4.437 18.918 2.95797C22.8619 -0.985989 29.3091 -0.985989 33.2532 2.95797C37.1972 6.90192 37.1972 13.3491 33.2532 17.2932C31.6983 18.8482 29.7264 19.7963 27.7162 20.1375L28.7783 16.952Z"
                           fill="#FCF9FC"
                        />
                        <path
                           d="M0.980057 16.3073L25.7823 8.03983C26.427 7.81233 27.1098 8.00201 27.5648 8.45701C28.0197 8.91202 28.2094 9.63259 27.9819 10.2394L19.7145 35.0417C19.2973 36.2932 17.5908 36.3692 17.0218 35.1933L11.9779 24.6884C11.8263 24.3849 11.5985 24.1574 11.2954 24.0059L0.790451 18.962C-0.347065 18.4313 -0.233295 16.7245 0.980123 16.3074L0.980057 16.3073Z"
                           fill="#FCF9FC"
                        />
                     </svg>
                  </template>
               </Button>
            </template>
         </Form>
      </section>
   </main>
</template>
