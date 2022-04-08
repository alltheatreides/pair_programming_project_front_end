<script setup>
import TheWelcome from "@/components/TheWelcome.vue";

const rest = "https://morpheebackend.herokuapp.com/api/statistics/1/latest/7";

async function fetchStat() {
   try {
      const response = await fetch(`${rest}`, {
         method: "POST",
         headers: {
            "Content-Type": "application/json",
         },
         body: JSON.stringify({
            user_email: "UserTest",
            user_id: 1,
         }),
      });
      const data = await response.json();
      console.log(data);
   } catch (error) {
      console.log(error);
   }
}

fetchStat();
</script>

<template>
   <main>
      <TheWelcome />
   </main>
</template>
