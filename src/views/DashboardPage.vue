<script setup></script>
<script>
export default {
   data() {
      return {};
   },
   methods: {
      // Method that should be used as a High Order Component/Function (or just use the vue-cookie package lol)
      getCookie(username) {
         let name = username + "=";
         let decodedCookie = decodeURIComponent(document.cookie);
         let ca = decodedCookie.split(";");
         for (let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == " ") {
               c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
               return c.substring(name.length, c.length);
            }
         }
         return "";
      },

      // REST call to get user info from the last 30 days
      async userLatestStat30() {
         // TODO need to put that rest adresse as an ENV global
         const rest = "http://127.0.0.1:8000";
         try {
            // On recupere l'info a travers la funcion getCookie. // tableau qui contient les info de cookies cree. On peut l'utiliser comme ca:cookie_user_info [1];
            let cookie_user_info = this.getCookie("user_info").split(",");

            const response = await fetch(
               `${rest}/api/statistics/${cookie_user_info[1]}/latest/30`,
               {
                  method: "POST",
                  headers: {
                     "Content-Type": "application/json",
                  },
                  body: JSON.stringify({
                     user_id: parseInt(cookie_user_info[1]),
                  }),
               }
            );
            const data = await response.json();
            console.log(data);
         } catch (error) {
            console.log(error);
         }
         // }
      },
   },
   // On component loaded (page)
   mounted() {
      this.userLatestStat30();
   },
};
</script>

<template>
   <main class="pt-24 md:pt-14">
      <section
         class="container mx-auto px-6 md:px-10 lg:px-0 flex flex-col items-center min-h-[90vh]"
      ></section>
   </main>
</template>
