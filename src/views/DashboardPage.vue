<script setup>
import { BarChart } from "vue-chart-3";
import { Chart, registerables } from "chart.js";
import router from "../router";
import FormStat from "../components/FormStat.vue";
import FormField from "../components/small/FormField.vue";
import Button from "../components/small/Button.vue";
import TestimonyCardVue from "../components/small/TestimonyCard.vue";
import { isIntegerKey } from "@vue/shared";
import Button1 from "../components/small/Button.vue";

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
         // Managing page reload
         mainKey: 0,
         // Variables to manage display of the charts
         displayChart: false,
         displayChartSeven: false,
         // Variable to manage the display of the error message if there are no 7 days statistics
         displayEmpty: false,
         // Variable to manage the display of the error message if there are no 30 days statistics
         displayEmpty30: false,
         displayLoading30: true,
         displayLoading7: true,

         // Manage Modal
         toggleAddStatModal: false,
         modalDelete: false,
         modalUpdate: false,
         displayModal: false,

         // Hacky way to store item ID to delete
         itemToDelete: 0,

         // input var definition
         user_date_input: Date,
         // user_heure_couche_input: String,
         // user_heure_reveil_input: String,
         user_date_2_input: Date,

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
         backendResponse: [],

         allStat: [],

         // Variables for UPDATE
         updateStatId: Number,
         updateDate: "",
         updateDateReveil: "",
         updateHeureCoucher: "",
         updateHeureReveil: "",

         // Test
         testValue: "Hello World",
         console: console,
      };
   },

   // Page Methods
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

            if (data.lastThirtyDaysStatistics.length <= 0) {
               this.displayLoading7 = false;
               this.displayEmpty30 = !this.displayEmpty30;
               // console.log(data);
            } else {
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
               this.displayLoading30 = false;
               // this.displayChart = !this.displayChart;
               this.displayChart = true;
            }
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
            ); // Object response with an array in it
            const data = await response.json();

            // console.log(data);

            // If response is empty, ie there are no statistics, handle the display of the error message that there are n
            if (data.lastSevenDaysStatistics.length <= 0) {
               this.displayLoading7 = false;
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
                  // let hours = Math.abs(heureReveil - heureCoucher) / 36e5;
                  let hours = Math.abs(heureCoucher - heureReveil) / 36e5;

                  // Populate internal array with calculated sleep hour
                  this.sleepHoursSeven.push(hours);
               });

               // WIP changing the label array with the recently populated label array
               this.chart7stat.datasets[0].data =
                  this.sleepHoursSeven.reverse();

               this.chart7stat.labels = this.dateLabelsSeven.reverse();
               this.displayLoading7 = false;
               // this.displayChartSeven = !this.displayChartSeven;
               this.displayChartSeven = true;
            }
         } catch (error) {
            console.log(error);
         }
      },

      // REST call to CREATE sleep statistic entry
      async addStat() {
         try {
            const rest = "http://127.0.0.1:8000";
            // Get cookie user id
            let cookie_user_info = this.getCookie("user_info").split(",");
            let user_id = cookie_user_info[1];

            // Transform date & hour form input to Unix timestamp
            // Date timestamp
            let user_date = new Date(this.user_date_input).getTime() / 1000;
            // Hours timestamps
            let user_heure_couche =
               new Date(
                  this.user_date_input + "T" + this.user_heure_couche_input
               ).getTime() / 1000;
            let user_heure_reveil =
               new Date(
                  this.user_date_2_input + "T" + this.user_heure_reveil_input
               ).getTime() / 1000;

            console.log(user_heure_couche, user_heure_reveil);

            const response = await fetch(
               `${rest}/api/user/${cookie_user_info[1]}/create`,
               {
                  method: "POST",
                  headers: {
                     "Content-Type": "application/json",
                  },

                  body: JSON.stringify({
                     user_id: parseInt(user_id),
                     date: user_date,
                     heure_couche: user_heure_couche,
                     heure_reveil: user_heure_reveil,
                  }),
               }
            );
            const data = await response.json();
            console.log(data);
            this.userLatestStat30();
            this.userLatestStat7();
            this.forceRerender();
         } catch (error) {
            console.log(error);
         }
      },

      // Open the add stat modal
      openAddStatModal() {
         this.toggleAddStatModal = !this.toggleAddStatModal;
      },

      // Manages the rerender with template keys
      forceRerender() {
         this.mainKey += 1;
      },

      // REST call to get all the user statistics for UPDATE & DELETE actions
      async showAll() {
         try {
            const rest = "http://127.0.0.1:8000";
            // Get cookie user id
            let cookie_user_info = this.getCookie("user_info").split(",");
            let user_id = cookie_user_info[1];

            const response = await fetch(
               `${rest}/api/statistics/${cookie_user_info[1]}/all`,
               {
                  method: "POST",
                  headers: {
                     "Content-Type": "application/json",
                  },

                  body: JSON.stringify({
                     user_id: parseInt(user_id),
                  }),
               }
            );
            const data = await response.json();

            this.allStat = data;

            data.showAllStatistics.map((entry) => {
               const options = {
                  year: "numeric",
                  month: "long",
                  day: "numeric",
               };

               const dateHeureReveil = new Date(entry.heure_reveil * 1000)
                  .toISOString()
                  .substring(0, 10);

               entry.date = new Date(entry.date * 1000);
               // Change Date format to html input format to populate existing statistics list
               entry.date = entry.date.toISOString().substring(0, 10);
               // Change Heure de coucher to html time input format
               entry.heure_couche = new Date(entry.heure_couche * 1000)
                  .toTimeString()
                  .substring(0, 5);
               entry.heure_reveil = new Date(entry.heure_reveil * 1000)
                  .toTimeString()
                  .substring(0, 5);

               // data.showAllStatistics.push(dateHeureReveil);
               entry.date_reveil = dateHeureReveil;
               // console.log(entry.date);
               // console.log(entry.heureCoucher);
               // console.log(entry.heure_couche);
               // console.log(dateHeureReveil);
            });
            console.log(this.allStat);

            this.forceRerender();
         } catch (error) {
            console.log(error);
         }
      },

      // REST call to delete a statistic
      async deleteStat(statId) {
         try {
            const rest = "http://127.0.0.1:8000";
            // Get cookie user id
            let cookie_user_info = this.getCookie("user_info").split(",");
            let user_id = cookie_user_info[1];

            const response = await fetch(
               `${rest}/api/statistics/${cookie_user_info[1]}/delete/${statId}`,
               {
                  method: "POST",
                  headers: {
                     "Content-Type": "application/json",
                  },

                  body: JSON.stringify({
                     user_id: parseInt(user_id),
                     statistic_id: parseInt(statId),
                  }),
               }
            );
            const data = await response.json();
            console.log(data);
         } catch (error) {
            console.log(error);
         }
      },

      // Testing testing
      test(event) {
         // event.preventDefault();
         // console.log(event.target.value);
         // const test = event.target.parentElement.value;
         // // event.target.value = test;
         // console.log(event.target.parentElement);
         // console.log(test);
         console.log(this.testValue);
      },

      displayModalAll() {
         this.displayModal = !this.displayModal;
      },

      // Opens confirmation modal and transfers array iterated information to an internal variable that can be called outside of the loop
      openDeleteModal(event) {
         // Displyaing the modal
         this.modalDelete = true;

         // Extracting from id iterated statistic
         this.itemToDelete = event.target.parentElement.value;
      },

      // Opens confirmation update modal and transfer array iterated info to internal updates variables that can be called outside of the loop
      openUpdateModal(event) {
         // Displyaing the modal
         this.modalUpdate = true;

         // Transferring info
         console.log(event.target.parentElement.parentElement.parentElement);
         console.log(
            event.target.parentElement.parentElement.parentElement.children[0]
               .children[1].value
         );
         console.log(
            event.target.parentElement.parentElement.parentElement.children[1]
               .children[1].value
         );
         console.log(
            event.target.parentElement.parentElement.parentElement.children[2]
               .children[1].value
         );
         console.log(
            event.target.parentElement.parentElement.parentElement.children[3]
               .children[1].value
         );
         this.updateStatId =
            event.target.parentElement.parentElement.parentElement.value;
         // Date heure de coucher
         this.updateDate =
            event.target.parentElement.parentElement.parentElement.children[0].children[1].value;
         // Heure de coucher
         this.updateHeureCoucher =
            event.target.parentElement.parentElement.parentElement.children[1].children[1].value;
         // Date heure de reveil
         this.updateDateReveil =
            event.target.parentElement.parentElement.parentElement.children[2].children[1].value;
         // Heure de reveil
         this.updateHeureReveil =
            event.target.parentElement.parentElement.parentElement.children[3].children[1].value;
      },

      async updateStat() {
         try {
            const rest = "http://127.0.0.1:8000";
            // Get cookie user id
            let cookie_user_info = this.getCookie("user_info").split(",");
            let user_id = cookie_user_info[1];

            // Transform date & hour form input to Unix timestamp
            // Date timestamp
            let user_date = new Date(this.updateDate).getTime() / 1000;
            // Hours timestamps
            let user_heure_couche =
               new Date(
                  this.updateDate + "T" + this.updateHeureCoucher
               ).getTime() / 1000;
            let user_heure_reveil =
               new Date(
                  this.updateDateReveil + "T" + this.updateHeureReveil
               ).getTime() / 1000;

            console.log(user_heure_couche, user_heure_reveil);

            const response = await fetch(
               `${rest}/api/statistics/${cookie_user_info[1]}/modify/${this.updateStatId}`,
               {
                  method: "POST",
                  headers: {
                     "Content-Type": "application/json",
                  },

                  body: JSON.stringify({
                     user_id: parseInt(user_id),
                     date: user_date,
                     heure_couche: user_heure_couche,
                     heure_reveil: user_heure_reveil,
                     statistic_id: this.updateStatId,
                  }),
               }
            );
            const data = await response.json();
            console.log(data);
            this.userLatestStat30();
            this.userLatestStat7();
            this.forceRerender();
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

      // TODO:deactivate below
      // Temporary display of all info for testing purposes
      this.showAll();
   },
};
</script>

<template>
   <main class="pt-24 md:pt-14" :key="mainKey">
      <section
         class="container mx-auto px-6 md:px-10 lg:px-0 flex flex-col min-h-[90vh]"
      >
         <!-- Title and buttons to open modals -->
         <div class="flex flex-col md:flex-row justify-between items-center">
            <h1 class="text-4xl font-bold text-left mb-5">
               Statistiques de sommeil
            </h1>
            <!-- Buttons to open modals -->
            <div class="flex justify-between my-auto items-center gap-2">
               <Button
                  text="Ajouter une entrée"
                  @click="openAddStatModal"
               ></Button>
               <Button
                  text="Modifier ou supprimer une entrée "
                  @click="displayModalAll"
               ></Button>
            </div>
         </div>
         <!-- Canvas chart 7 days -->
         <div
            v-if="displayChartSeven"
            class="mb-16 lg:mb-20 grid grid-cols-1 lg:grid-cols-2 gap-6 items-center"
         >
            <BarChart
               :chartData="chart7stat"
               :options="chart7options"
               class="h-[50vh] grid place-content-center"
            />
            <div class="md:px-10">
               Sur les 7derniers jours vous avez mal dormi le lundi, mardi et
               mercredi, 7heures de sommeil ne sont pas assez.
            </div>
         </div>
         <!-- Loading icon inbetween rest call -->
         <div v-if="displayLoading7" class="text-xl flex items-center mb-20">
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
         <!-- Display s'il n'y a pas données les 7 derniers jours -->
         <div v-if="displayEmpty" class="mb-20">
            <p>Vous n'avez pas de données pour les 7 derniers jours</p>
         </div>

         <!-- Canvas CHART 30 days -->
         <div
            v-if="displayChart"
            class="mb-16 lg:mb-20 grid grid-cols-1 lg:grid-cols-2 gap-6 items-center"
         >
            <BarChart
               :chartData="chart30stat"
               :options="chart30options"
               class="h-[50vh] grid place-content-center"
            />
            <div class="md:px-10">
               <p class="mb-10">
                  Lorem ipsum dolor sit amet consectetur adipisicing elit. Neque
                  dolore quidem aperiam quibusdam libero ipsam eligendi, a sunt
                  laboriosam nam, quo laborum, id rerum quos dolorum blanditiis
                  dolor vero corporis!
               </p>
               <p>
                  Lorem ipsum dolor sit amet consectetur adipisicing elit. Neque
                  dolore quidem aperiam quibusdam libero ipsam eligendi, a sunt
                  laboriosam nam, quo laborum, id rerum quos dolorum blanditiis
                  dolor vero corporis!
               </p>
            </div>
         </div>
         <!-- Loading icon inbetween rest call -->
         <div v-if="displayLoading30" class="text-xl flex items-center mb-20">
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
         <!-- Display s'il n'y a pas données les 30 derniers jours -->
         <div v-if="displayEmpty30" class="mb-20">
            <p>Vous n'avez pas de données pour les 30 derniers jours</p>
         </div>

         <!-- Modal Create statistic form -->
         <FormStat
            class="absolute inset-x-0 w-fit mx-auto bg-[#235077] p-10 flex flex-col"
            v-if="toggleAddStatModal"
         >
            <template #field>
               <!-- Button to close the modal -->
               <svg
                  viewBox="0 0 334 334"
                  fill="#FCF9FC"
                  xmlns="http://www.w3.org/2000/svg"
                  class="w-[25px] self-end cursor-pointer"
                  @click="openAddStatModal"
               >
                  <path
                     fill-rule="evenodd"
                     clip-rule="evenodd"
                     d="M206.184 166.576L324.954 47.806C335.884 36.876 335.907 19.122 324.973 8.18904C314.059 -2.72096 296.301 -2.73696 285.356 8.20857L166.576 126.979L47.806 8.20857C36.876 -2.72143 19.122 -2.74442 8.18904 8.18904C-2.72096 19.103 -2.73696 36.861 8.20857 47.806L126.979 166.576L8.20857 285.356C-2.72143 296.286 -2.74442 314.04 8.18904 324.973C19.103 335.883 36.861 335.899 47.806 324.953L166.576 206.184L285.356 324.953C296.286 335.883 314.04 335.906 324.973 324.973C335.883 314.059 335.899 296.301 324.954 285.356L206.184 166.576Z"
                     fill="#FCF9FC"
                  />
               </svg>
               <!-- title -->
               <h2 class="text-3xl mb-6">Ajouter une entrée:</h2>
               <!-- Input for heure de coucher -->
               <div
                  class="flex flex-col md:flex-row gap-20 bg-themeSecondaryDarker p-6 rounded-xl w-fit md:w-full mb-10 mx-auto"
               >
                  <FormField
                     label="Date du coucher"
                     type="date"
                     :modelValue="user_date_input"
                     @update:modelValue="
                        (newValue) => (user_date_input = newValue)
                     "
                  />
                  <FormField
                     label="Heure de coucher"
                     type="time"
                     :modelValue="user_heure_couche_input"
                     @update:modelValue="
                        (newValue) => (user_heure_couche_input = newValue)
                     "
                  />
               </div>
               <!-- Input for heure de réveil -->
               <div
                  class="flex flex-col md:flex-row gap-20 bg-themeSecondaryDarker p-6 rounded-xl w-fit md:w-full mb-10 mx-auto"
               >
                  <FormField
                     label="Date du réveil"
                     type="date"
                     :modelValue="user_date_2_input"
                     @update:modelValue="
                        (newValue) => (user_date_2_input = newValue)
                     "
                  />
                  <FormField
                     label="Heure de réveil"
                     type="time"
                     :modelValue="user_heure_reveil_input"
                     @update:modelValue="
                        (newValue) => (user_heure_reveil_input = newValue)
                     "
                  />
               </div>
               <!-- Button to trigger the async add stat call -->
               <Button text="Enregistrer" @click="addStat" class=""></Button>
            </template>
         </FormStat>

         <!-- Modal Update/Delete statistic form -->
         <FormStat
            class="absolute inset-x-0 w-fit mx-auto h-[80vh] bg-[#235077] p-10 flex flex-col"
            v-if="displayModal"
         >
            <template #field>
               <!-- Button to close the modal -->
               <svg
                  viewBox="0 0 334 334"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                  class="w-[5%] self-end cursor-pointer"
                  @click="displayModalAll"
               >
                  <path
                     fill-rule="evenodd"
                     clip-rule="evenodd"
                     d="M206.184 166.576L324.954 47.806C335.884 36.876 335.907 19.122 324.973 8.18904C314.059 -2.72096 296.301 -2.73696 285.356 8.20857L166.576 126.979L47.806 8.20857C36.876 -2.72143 19.122 -2.74442 8.18904 8.18904C-2.72096 19.103 -2.73696 36.861 8.20857 47.806L126.979 166.576L8.20857 285.356C-2.72143 296.286 -2.74442 314.04 8.18904 324.973C19.103 335.883 36.861 335.899 47.806 324.953L166.576 206.184L285.356 324.953C296.286 335.883 314.04 335.906 324.973 324.973C335.883 314.059 335.899 296.301 324.954 285.356L206.184 166.576Z"
                     fill="#FCF9FC"
                  />
               </svg>
               <!-- title -->
               <h2 class="text-3xl mb-6">Modifier ou supprimer une entrée:</h2>
               <!-- List of statistic entries -->
               <ul class="overflow-scroll px-4 flex flex-col gap-10">
                  <!-- List of statistic entries with buttons to delete/update inside them -->
                  <li
                     v-for="item in this.allStat.showAllStatistics"
                     class="flex gap-6 items-center border-b-2 border-themeTertiary pb-4"
                     :key="item.stat_id"
                     v-bind:value="item.stat_id"
                  >
                     <!-- Date Entry -->
                     <div class="flex flex-col h-full">
                        <label
                           @click="test"
                           class="mb-4 text-base font-semibold min-h-[50%] whitespace-nowrap"
                           >Date:</label
                        >
                        <!-- To do, save the changed value in an internal variable for later UPDATE async method -->
                        <input
                           type="date"
                           class="text-themeSecondary h-12 md:h-14 rounded-xl px-4"
                           :value="item.date"
                           @change="
                              (event) => {
                                 console.log(event.target.value);
                              }
                           "
                        />
                     </div>
                     <!-- Heure de coucher entry -->
                     <div class="flex flex-col h-full">
                        <label
                           @click="test"
                           class="mb-4 text-base font-semibold min-h-[50%] whitespace-nowrap"
                           >Heure de coucher:</label
                        >
                        <!-- To do, save the changed value in an internal variable for later UPDATE async method -->
                        <input
                           type="time"
                           class="text-themeSecondary h-12 md:h-14 rounded-xl px-4"
                           :value="item.heure_couche"
                           @change="
                              (event) => {
                                 console.log(event.target.value);
                              }
                           "
                           @click="
                              () => {
                                 console.log(item.heure_couche);
                              }
                           "
                        />
                     </div>
                     <!-- Date Entry 2 -->
                     <div class="flex flex-col h-full">
                        <label
                           @click="test"
                           class="mb-4 text-base font-semibold min-h-[50%] whitespace-nowrap"
                           >Date de réveil:</label
                        >
                        <input
                           type="date"
                           class="text-themeSecondary h-12 md:h-14 rounded-xl px-4"
                           :value="item.date_reveil"
                           @change="
                              (event) => {
                                 console.log(event.target.value);
                              }
                           "
                        />
                     </div>
                     <!-- Heure de reveil entry -->
                     <div class="flex flex-col h-full">
                        <label
                           @click="test"
                           class="mb-4 text-base font-semibold min-h-[50%] whitespace-nowrap"
                           >Heure de réveil:</label
                        >
                        <!-- To do, save the changed value in an internal variable for later UPDATE async method -->
                        <input
                           type="time"
                           class="text-themeSecondary h-12 md:h-14 rounded-xl px-4"
                           :value="item.heure_reveil"
                           @change="
                              (event) => {
                                 console.log(event.target.value);
                              }
                           "
                           @click="
                              () => {
                                 console.log(item.heure_reveil);
                              }
                           "
                        />
                     </div>
                     <!-- Buttons to delete/update entry -->
                     <div class="flex flex-col gap-4">
                        <!-- Button to delete entry -->
                        <Button
                           @click="openDeleteModal"
                           class="cursor-pointer"
                           text="Supprimer la statistique"
                        >
                        </Button>
                        <!-- Button to update entry -->
                        <Button
                           @click="openUpdateModal"
                           class="cursor-pointer"
                           text="Mettre à jour la statistique"
                        >
                        </Button>
                     </div>
                  </li>
                  <!-- Sub modal to confirm delete entry -->
                  <div
                     v-if="modalDelete"
                     class="fixed inset-x-0 w-fit mx-auto bg-themeSecondary p-10 rounded-2xl flex gap-6"
                  >
                     <!-- Paragraph to explain the irreversible act the user is about to commit themselves -->
                     <p class="bold">
                        Vous êtes sur le point de supprimer la statistique du
                        {{ updateDate }} !
                     </p>
                     <!-- TODO rafraichir les elements DOM au moment de la suppression des entrées et bouger ça en methode ? -->
                     <Button
                        @click="
                           () => {
                              deleteStat(this.itemToDelete);
                              this.itemToDelete = 0;
                           }
                        "
                        text="Oui, supprimer l'entrée."
                     >
                     </Button>
                     <Button
                        @click="
                           () => {
                              modalDelete = false;
                           }
                        "
                        text="Non, annuler l'opération."
                     >
                     </Button>
                  </div>
                  <!-- //TODO rafraichir les elements DOM au moment de l'upload des entrées  -->
                  <!-- Sub modal to confirm update -->
                  <div
                     v-if="modalUpdate"
                     class="fixed inset-x-0 w-fit mx-auto bg-themeSecondary p-10 rounded-2xl flex gap-6"
                  >
                     <!-- Paragraph to explain the irreversible act the user is about to commit themselves -->
                     <p class="bold">
                        Vous êtes sur le point de modifier la statistique du
                        {{ updateDate }} !
                     </p>
                     <!-- //TODO rafraichir les elements DOM au moment de la suppression des entrées et bouger ça en methode ? -->
                     <!-- Button to confirm update -->
                     <Button
                        @click="
                           () => {
                              updateStat();
                           }
                        "
                        text="Oui, modifier l'entrée."
                     >
                     </Button>
                     <!-- Button to cancel update -->
                     <Button
                        @click="
                           () => {
                              modalUpdate = false;
                           }
                        "
                        text="Non, annuler l'opération."
                     >
                     </Button>
                  </div>
               </ul>
            </template>
         </FormStat>
      </section>
   </main>
</template>
