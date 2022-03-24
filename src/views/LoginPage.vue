<script setup>
import Form from "../components/small/Form.vue";
import FormField from "../components/small/FormField.vue";
import Button from "../components/small/Button.vue";
import router from "../router";

</script>

<script>
// console.log("coucou");
// let data = {
//    message: "",
//    user_info: ["UserTest,1,$2y$10$cR7tjNXARFas5/edmtwuW./kdf887g.AwuIlwyMZFfMd12Pd5UNOG"]
// }

// function getCookie(username) {
//    let name = username + "=";
//    let decodedCookie = decodeURIComponent(document.cookie);
//    let ca = decodedCookie.split(';');
//    for (let i = 0; i < ca.length; i++) {
//       let c = ca[i];
//       while (c.charAt(0) == ' ') {
//          c = c.substring(1);
//       }
//       if (c.indexOf(name) == 0) {
//          return c.substring(name.length, c.length);
//       }
//    }
//    return "";
// }
// let test = (getCookie("username"));
// // tableau qui contient les info de cookies cree. On peut l'utiliser comme ca:nameUserMorphee[1];
// let nameUserMorphee = test.split(",");
// console.log(nameUserMorphee[1]);
// document.cookie = `username=${data['user_info'][0]}`;
// let onaunecookie = decodeURIComponent(document.cookie("username"));
// document.cookie.split(';');
// decodeURIComponent(document.cookie)
// console.log(onaunecookie);
// splitString(  document.cookie.split(';');

export default {
   data() {
      return {
         // booleans to display hmtl tag errors
         displayErrorUserName: false,
         displayErrorPassword: false,
         // Display the json response
         restMessageReturn: false,
         backendResponse: [],
      };
   },
   methods: {
      // Externalized field validation method to check login input info
      checkLoginFormInputs() {
         // Assigning an arbitrary string value true as the return string of the check form input function
         let noErrors = "true";

         // Checking if user name input is not empty or a number
         //regex pour verifier si c'est un mail.
         let mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
         if (
            this.user_email_input === undefined ||
            (this.user_email_input != undefined &&
               !this.user_email_input.match(mailformat))
         ) {
            // triggers display of error tag element
            this.displayErrorUserName = true;
            noErrors = "error type 1";
         } else {
            this.displayErrorUserName = false;
         }

         // checking if a password is not empty
         if (this.user_password_input === undefined) {
            // triggers display of error tag element
            this.displayErrorPassword = true;
            noErrors = "error type 3";
         } else {
            this.displayErrorPassword = false;
         }

         return noErrors;
      },
      //function pour obtenir le cookie d'utilisateur qui est retourné de backoffice en forme de data[user_info]
      getCookie(username) {
         let name = username + "=";
         let decodedCookie = decodeURIComponent(document.cookie);
         let ca = decodedCookie.split(';');
         for (let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == ' ') {
               c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
               return c.substring(name.length, c.length);
            }
         }
         return "";
      },
      // REST call to login user
      async login() {
         const rest = "http://127.0.0.1:8000";
         // Checking on field inputs
         console.log(this.checkLoginFormInputs());
         console.log("you clicked on the button ahaha");
         if (this.checkLoginFormInputs() === "true") {
            try {
               const response = await fetch(`${rest}/api/login`, {
                  method: "POST",
                  headers: {
                     "Content-Type": "application/json",
                  },
                  body: JSON.stringify({
                     user_email: this.user_email_input,
                     user_password: this.user_password_input,
                  }),
               });
               const data = await response.json();
               this.restMessageReturn = !this.restMessageReturn;
               this.backendResponse = data;
               router.push("/dashboard");
               console.log(data);
               //On cree le cookie avec les donnes returnes de Bo.
               document.cookie = `user_info=${data['user_info']}`;



            } catch (error) {
               console.log(error);
            }
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
         <Form title="Connectez vous !" buttonText="Se connecter" buttonLink="#">
            <template #field>
               <FormField
                  label="Email"
                  type="text"
                  :modelValue="user_email_input"
                  @update:modelValue="
                     (newValue) => (user_email_input = newValue)
                  "
               />
               <div
                  class="mb-10 text-base lg:text-lg needtodothisforsomereason"
                  v-if="displayErrorMail"
               >Le mail donné n'est pas au bon format</div>
               <FormField
                  label="Mot de passe"
                  type="password"
                  :modelValue="user_password_input"
                  @update:modelValue="
                     (newValue) => (user_password_input = newValue)
                  "
               />
               <div
                  class="mb-10 text-base lg:text-lg needtodothisforsomereason"
                  v-if="displayErrorPassword"
               >Le mot de passe est vide !</div>
               <Button @click="login" text="Se connecter">
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

         <div
            class="mt-6 bg-themeSecondaryDarker p-6 rounded-xl text-lg needtodothisforsomereason"
            v-if="restMessageReturn"
         >{{ backendResponse.message }}</div>
      </section>
   </main>
</template>

<style scoped>
.needtodothisforsomereason {
   color: rgb(220 38 38);
}
</style>
