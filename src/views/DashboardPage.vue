<script setup>
import { BarChart } from "vue-chart-3";
import { Chart, registerables } from "chart.js";
import router from "../router";

// Used to make the chart work
Chart.register(...registerables);
</script>
<script>
export default {
   // Check before mounting the page that an user cookie is present, if not redirect to the 404 page
   beforeMount() {
      if (this.getCookie("user_info") === "") {
         return router.push("/404");
      }
   },
   // Variables declaration
   data() {
      return {
         // Variables to manage display of the charts
         displayChart: false,
         displayChartSeven: false,
         // Variable to manage the display of the error message if there are no 7 days statistics
         displayEmpty: false,

         // Empty arrays to hold the first chart with 30 days statistics
         dateLabels: [],
         sleepHours: [],
         // 30 days statistics chart dataset & labels
         chart30stat: {
            datasets: [
               {
                  backgroundColor: ["#3FA7D8", "#3fa7d866"],
                  color: "#fff",
               },
            ],
         },
         // Last 30 days Chart Options
         chart30options: {
            responsive: true,
            plugins: {
               legend: {
                  display: false,
               },
               title: {
                  display: true,
                  text: "Statistiques de sommeil sur les 30 derniers jours",
                  color: "#FCF9FC",
                  font: {
                     size: 36,
                  },
               },
               subtitle: {
                  display: true,
                  text: "Heures de sommeil par jour",
               },
               tooltip: {
                  callbacks: {
                     label: function (context) {
                        return `${context.parsed.y} heures`;
                     },
                  },
               },
            },
            scales: {
               y: {
                  ticks: {
                     color: "#FCF9FC",
                  },
                  grid: {
                     color: "rgb(252,249,252, 0.1)",
                  },
               },
               x: {
                  ticks: {
                     color: "#FCF9FC",
                  },
                  grid: {
                     color: "rgb(252,249,252, 0.1)",
                  },
               },
            },
         },

         // Empty arrays to hold the first chart with 30 days statistics
         dateLabelsSeven: [],
         sleepHoursSeven: [],
         // 7 days statistics chart dataset & labels
         chart7stat: {
            datasets: [
               {
                  backgroundColor: ["#3FA7D8", "#3fa7d866"],
                  color: "#fff",
               },
            ],
         },
         // Last 7 days Chart Options
         chart7options: {
            responsive: true,
            plugins: {
               legend: {
                  display: false,
               },
               title: {
                  display: true,
                  text: "Statistiques de sommeil sur les 7 derniers jours",
                  color: "#FCF9FC",
                  font: {
                     size: 36,
                  },
               },
               subtitle: {
                  display: true,
                  text: "Heures de sommeil par jour",
               },
               tooltip: {
                  callbacks: {
                     label: function (context) {
                        return `${context.parsed.y} heures`;
                     },
                  },
               },
            },
            scales: {
               y: {
                  ticks: {
                     color: "#FCF9FC",
                  },
                  grid: {
                     color: "rgb(252,249,252, 0.1)",
                  },
               },
               x: {
                  ticks: {
                     color: "#FCF9FC",
                  },
                  grid: {
                     color: "rgb(252,249,252, 0.1)",
                  },
               },
            },
         },
      };
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
            // Object response with an array in it
            const data = await response.json();
            // console.log(data);

            // Looping over the data array to populate the ChartJS label array and data array
            data.lastThirtyDaysStatistics.map((entry) => {
               // Converting the unix date timestamp to human readable dates
               const date = new Date(entry.date * 1000);
               this.dateLabels.push(date.toLocaleDateString());

               // Converting unix hours timestamp to human readeable dates
               const heureCoucher = new Date(entry.heure_couche * 1000);
               const heureReveil = new Date(entry.heure_reveil * 1000);

               // Calculating hour difference between coucher et réveil
               let hours = Math.abs(heureReveil - heureCoucher) / 36e5;

               // Populate internal array with calculated sleep hour
               this.sleepHours.push(hours);
            });

            // WIP changing the label array with the recently populated label array
            this.chart30stat.datasets[0].data = this.sleepHours.reverse();
            this.chart30stat.labels = this.dateLabels.reverse();

            this.displayChart = !this.displayChart;
         } catch (error) {
            console.log(error);
         }
      },
      // REST call to get user info from the last 7 days
      async userLatestStat7() {
         // TODO need to put that rest adresse as an ENV global
         const rest = "http://127.0.0.1:8000";
         try {
            // On recupere l'info a travers la funcion getCookie. // tableau qui contient les info de cookies cree. On peut l'utiliser comme ca:cookie_user_info [1];
            let cookie_user_info = this.getCookie("user_info").split(",");

            const response = await fetch(
               `${rest}/api/statistics/${cookie_user_info[1]}/latest/7`,
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
            // Object response with an array in it
            const data = await response.json();

            console.log(data.lastSevenDaysStatistics);

            // If response is empty, ie there are no statistics, handle the display of the error message that there are no stat
            if (data.lastSevenDaysStatistics.length <= 0) {
               this.displayEmpty = !this.displayEmpty;
            } else {
               // Looping over the data array to populate the ChartJS label array and data array
               data.lastSevenDaysStatistics.map((entry) => {
                  // Converting the unix date timestamp to human readable dates
                  const date = new Date(entry.date * 1000);
                  this.dateLabelsSeven.push(date.toLocaleDateString());

                  // Converting unix hours timestamp to human readeable dates
                  const heureCoucher = new Date(entry.heure_couche * 1000);
                  const heureReveil = new Date(entry.heure_reveil * 1000);

                  // Calculating hour difference between coucher et réveil
                  let hours = Math.abs(heureReveil - heureCoucher) / 36e5;
                  console.log(hours);

                  // Populate internal array with calculated sleep hour
                  this.sleepHoursSeven.push(hours);
               });

               // WIP changing the label array with the recently populated label array
               this.chart7stat.datasets[0].data =
                  this.sleepHoursSeven.reverse();

               this.chart7stat.labels = this.dateLabelsSeven.reverse();

               this.displayChartSeven = !this.displayChartSeven;
            }
         } catch (error) {
            console.log(error);
         }
      },
   },
   // On component loaded (page)
   mounted() {
      // REST Async call to get user statistics
      this.userLatestStat30();
      this.userLatestStat7();
   },
};
</script>

<template>
   <main class="pt-24 md:pt-14">
      <section
         class="container mx-auto px-6 md:px-10 lg:px-0 flex flex-col items-center min-h-[90vh]"
      >
         <!-- Canvas chart 7 days -->
         <div v-if="displayChartSeven" class="lg:w-4/6 mb-20">
            <BarChart :chartData="chart7stat" :options="chart7options" />
         </div>
         <!-- Loading icon inbetween rest call -->
         <div v-else class="text-xl flex items-center mb-20">
            <svg
               role="status"
               class="inline w-10 h-10 mr-4 text-gray-200 animate-spin"
               viewBox="0 0 100 101"
               fill="none"
               xmlns="http://www.w3.org/2000/svg"
            >
               <path
                  d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                  fill="currentColor"
               />
               <path
                  d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                  fill="#1C64F2"
               />
            </svg>
            Chargement...
         </div>
         <div v-if="displayEmpty" class="mb-20">
            <p>Vous n'avez pas de données pour les 7 derniers jours</p>
         </div>

         <!-- Canvas CHART 30 days -->
         <div v-if="displayChart" class="lg:w-4/6 mb-20">
            <BarChart :chartData="chart30stat" :options="chart30options" />
         </div>
         <!-- Loading icon inbetween rest call -->
         <div v-else class="text-xl flex items-center mb-20">
            <svg
               role="status"
               class="inline w-10 h-10 mr-4 text-gray-200 animate-spin"
               viewBox="0 0 100 101"
               fill="none"
               xmlns="http://www.w3.org/2000/svg"
            >
               <path
                  d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                  fill="currentColor"
               />
               <path
                  d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                  fill="#1C64F2"
               />
            </svg>
            Chargement...
         </div>
      </section>
   </main>
</template>
