<script setup>
// functions
</script>

<script>
import router from "../router";

export default {
   data() {
      return {
         loggedIn: false,
         headerKey: 0,
         toggleModal: false,
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

      // toggles the modal
      openModalMenu() {
         this.toggleModal = !this.toggleModal;
      },

      // Verify that user_info cookie exists, if yes change loggein status to true
      checkLoggedIn() {

         if (this.getCookie("user_info") !== "") {

            if (!this.loggedIn) {
               this.loggedIn = true;

            }

         }

      },

      // test() {
      //    browser.cookies.onChanged.hasListener(callback);
      // },

      // Remove cookies and trigger a heaer component rerender
      disconnect() {
         // if not on the main page, redirect to the main page
         // console.log("Beam me up scotty");
         router.push("/");

         // Remove the cookie
         document.cookie =
            "user_info=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";

         // Updating the tracking logged in variable
         this.loggedIn = false;

         // Triggers a rerender of the header component so the navbar options are updated
         this.forceRerender();
      },
      // Manages the rerender with template keys
      forceRerender() {
         this.headerKey = this.headerKey + 1;
         console.log("coucou ça marche");
      },
   },

   // On component mounted/change, make sure to check user logged in status to display proper navbar options
   mounted() {
      this.checkLoggedIn();
      // this.test();

   },
   // On component mounted/change, make sure to check user logged in status to display proper navbar options
   updated() {
      this.checkLoggedIn();

   },
};
</script>

<template>
   <header
      class="bg-themeQuaternary md:bg-themeQuaternaryDarker flex z-20 items-center justify-between w-full px-4 md:px-10 lg:px-0 py-4 fixed md:relative"
      :key="headerKey"
   >
      <div class="container mx-auto flex justify-between">
         <!-- Logo and Brand Name  -->
         <router-link to="/" class="flex gap-2 items-center">
            <p class="uppercase font-bold text-2xl">Morphee</p>
            <svg
               width="55"
               height="37"
               viewBox="0 0 55 37"
               fill="none"
               xmlns="http://www.w3.org/2000/svg"
            >
               <path
                  d="M2.26246 16.8342H2.33934C3.54917 16.8342 4.74827 15.7345 5.69388 14.5574C6.71677 17.8572 8.76253 20.8048 11.5564 20.8048C14.5924 20.8048 16.7482 17.3181 17.661 13.6662C19.0029 14.5901 20.7407 15.5583 22.1269 15.5583C22.4896 15.5583 22.8307 15.4925 23.1277 15.3382C23.6778 15.0524 24.3153 14.4033 24.2385 12.9513C24.0074 9.04668 19.5526 7.82589 17.837 7.40788C17.0668 4.40511 14.8451 2.67828 11.5565 2.67828C8.20193 2.67828 5.94667 4.47134 5.22072 7.59479C3.61504 8.59558 -1.27978 12.0274 0.315294 15.393C0.898548 16.6033 1.77826 16.8123 2.2625 16.8343L2.26246 16.8342ZM11.5568 4.87853C13.2946 4.87853 15.3187 5.54925 15.8247 8.4531V8.46415C15.8247 8.4752 15.8247 8.4752 15.8357 8.4752C15.9015 8.91529 15.9457 9.41016 15.9457 9.96032C15.9457 10.4552 15.9126 10.9501 15.8578 11.4344C15.8468 11.4675 15.8468 11.5002 15.8468 11.5333C15.374 15.1521 13.383 18.6056 11.5573 18.6056C9.4674 18.6056 7.15781 14.0851 7.15781 9.96042C7.15689 5.7589 9.55484 4.87869 11.5568 4.87869L11.5568 4.87853Z"
                  fill="#FCF9FC"
               />
               <path
                  d="M10.6002 10.5753C10.6002 10.2895 10.4792 10.0036 10.2702 9.79459C9.86322 9.38764 9.12621 9.38764 8.71928 9.79459C8.51029 10.0036 8.40027 10.2784 8.40027 10.5753C8.40027 10.8612 8.51029 11.1471 8.71928 11.3561C8.91723 11.554 9.20311 11.6751 9.50003 11.6751C9.7859 11.6751 10.0718 11.554 10.2702 11.3561C10.4792 11.1471 10.6003 10.8612 10.6003 10.5753H10.6002Z"
                  fill="#FCF9FC"
               />
               <path
                  d="M12.8217 11.3567C12.8659 11.4009 12.9207 11.4446 12.9865 11.4888C13.0413 11.533 13.1076 11.5657 13.1734 11.5878C13.2392 11.6209 13.3055 11.6426 13.3824 11.6536C13.4482 11.6647 13.5256 11.6757 13.5914 11.6757C13.8883 11.6757 14.1631 11.5546 14.3721 11.3567C14.5811 11.1477 14.6911 10.8618 14.6911 10.576C14.6911 10.279 14.5811 10.0042 14.3721 9.79521C14.1189 9.54203 13.7451 9.42141 13.3824 9.49829C13.3055 9.50934 13.2392 9.53144 13.1734 9.56412C13.1076 9.58622 13.0413 9.6189 12.9865 9.6631C12.9207 9.69624 12.8654 9.75102 12.8217 9.79521C12.6127 10.0042 12.4916 10.279 12.4916 10.576C12.4916 10.7191 12.5248 10.8618 12.5796 10.994C12.6348 11.1261 12.7227 11.2467 12.8217 11.3567L12.8217 11.3567Z"
                  fill="#FCF9FC"
               />
               <path
                  d="M45.8969 8.02395C45.5669 6.89104 44.6098 6.01134 43.4111 5.74712C43.1473 4.27308 41.8054 3.1402 40.1881 3.08541C39.5174 1.94145 38.0982 1.2597 36.7015 1.46865C35.8107 0.34679 34.0835 -0.137036 32.6536 0.467855C31.6418 -0.125993 30.2667 -0.159131 29.2107 0.413076C28.1657 -0.158676 26.769 -0.13704 25.7351 0.478904C24.5253 -0.0491151 22.9855 0.215124 22.0174 1.08379C20.7633 0.753725 19.3778 1.17172 18.5529 2.10668C18.0907 2.11773 17.64 2.2167 17.2442 2.39256C17.618 2.70053 17.9701 3.0527 18.2781 3.43754C18.4102 3.59176 18.5313 3.75656 18.6519 3.93241C18.773 4.09721 18.883 4.27352 18.982 4.46043C19.0699 4.59255 19.1468 4.73525 19.2131 4.87842C19.3452 5.10951 19.4552 5.35119 19.5542 5.60439C24.9549 7.27642 26.2969 10.4108 26.4396 12.8199C26.5385 14.8546 25.7136 16.4718 24.1406 17.2857C23.5357 17.6048 22.8645 17.7585 22.128 17.7585C21.1488 17.7585 20.0822 17.4837 18.8941 16.9336C18.8831 16.9667 18.872 16.9883 18.861 17.0104C18.773 17.2194 18.6851 17.4284 18.5751 17.6264C18.4761 17.8464 18.3661 18.0665 18.234 18.2865C18.0471 18.6493 17.827 19.0014 17.5959 19.3426C17.4311 19.5847 17.2659 19.8153 17.09 20.0354C16.991 20.1564 16.9031 20.2775 16.7931 20.3875C16.7273 20.4755 16.6499 20.5634 16.562 20.6407C16.463 20.7618 16.353 20.8718 16.2319 20.9818C16.0777 21.136 15.924 21.2788 15.7697 21.3998C15.6155 21.5319 15.4618 21.653 15.297 21.7626C15.2749 21.7957 15.2422 21.8068 15.2201 21.8284C15.924 22.6091 17.0021 23.0714 18.1349 22.9503C18.7288 24.0284 19.9828 24.7322 21.3246 24.6549C22.3144 25.722 24.1074 26.0411 25.4493 25.3588C26.0321 25.7989 26.758 26.0406 27.5283 26.0406C28.2432 26.0406 28.9144 25.8316 29.4861 25.4467C30.5532 25.9089 31.8508 25.7878 32.7969 25.1719C34.0399 25.623 35.4807 25.304 36.3936 24.4349C37.8892 24.5997 39.2533 23.7642 39.8255 22.5429C41.2885 22.5318 42.5425 21.641 42.9931 20.376C44.5551 20.0901 45.7428 18.7809 45.7428 17.2194V17.1094C46.4577 16.5155 46.8867 15.6464 46.8978 14.7336C48.0854 15.4927 49.7464 16.3066 51.4073 16.3066C52.3644 16.3066 53.3104 16.0318 54.1681 15.3169C55.0699 14.5688 55.0478 13.7329 54.9599 13.2932C54.476 10.9495 48.8994 8.93693 45.8971 8.02408L45.8969 8.02395Z"
                  fill="#FCF9FC"
               />
               <path
                  d="M43.686 32.9253C43.686 32.7711 43.675 32.6173 43.6529 32.4631L42.5089 24.0594C42.0799 24.2905 41.6071 24.4774 41.1228 24.5875C40.1547 25.7862 38.7028 26.5453 37.1302 26.6443C36.7564 26.8864 36.3601 27.0844 35.9426 27.2271L36.7786 33.3975C37.0096 35.1021 38.4832 36.3893 40.2215 36.3893C41.2223 36.3893 42.1683 35.9602 42.8284 35.2016C43.3891 34.5751 43.686 33.7612 43.686 32.9253L43.686 32.9253Z"
                  fill="#FCF9FC"
               />
               <path
                  d="M18.4972 36.3912C20.2239 36.3912 21.698 35.1041 21.9291 33.3994L22.6882 27.7896C21.8743 27.6354 21.1151 27.2947 20.4665 26.8215C19.1467 26.6673 17.9258 26.0513 17.0236 25.1168C16.7046 25.0726 16.3966 25.0068 16.0886 24.9078L15.0657 32.4643C14.9336 33.4541 15.2305 34.4554 15.8907 35.214C16.5503 35.962 17.4964 36.3911 18.4971 36.3911L18.4972 36.3912Z"
                  fill="#FCF9FC"
               />
            </svg>
         </router-link>

         <!-- Navbar -->
         <nav class="hidden md:block">
            <ul class="flex gap-6 uppercase text-2xl">
               <router-link to="/" class="font-semibold">Accueil</router-link>
               <!-- Rajouter une condition d'existence de cookie user avant d'afficher le lien ci dessous -->
               <router-link to="/login" v-if="!loggedIn" class="font-semibold">Connexion</router-link>
               <!-- Rajouter une condition d'existence de cookie user avant d'afficher le lien ci dessous -->
               <router-link to="/register" v-if="!loggedIn" class="font-semibold">Inscription</router-link>
               <router-link to="/dashboard" v-if="loggedIn" class="uppercase">Dashboard</router-link>
               <button v-if="loggedIn" @click="disconnect" class="uppercase">Déconnexion</button>
            </ul>
         </nav>

         <!-- hamburger button -->
         <button @click="openModalMenu" class="md:hidden">
            <svg
               width="26"
               height="18"
               viewBox="0 0 26 18"
               fill="none"
               xmlns="http://www.w3.org/2000/svg"
            >
               <path
                  d="M13 17.5H0.25V14.6667H13V17.5ZM25.75 10.4167H0.25V7.58333H25.75V10.4167ZM25.75 3.33333H13V0.5H25.75V3.33333Z"
                  fill="white"
               />
            </svg>
         </button>
      </div>
      <!-- Modal popup -->
      <div
         v-if="toggleModal"
         class="absolute inset-y-0 right-0 h-screen z-10 bg-themeSecondary pt-6 px-6"
      >
         <nav class>
            <ul class="flex flex-col gap-6 text-xl text-right uppercase font-bold">
               <svg
                  viewBox="0 0 334 334"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                  class="w-[25px] self-end cursor-pointer"
                  @click="openModalMenu"
               >
                  <path
                     fill-rule="evenodd"
                     clip-rule="evenodd"
                     d="M206.184 166.576L324.954 47.806C335.884 36.876 335.907 19.122 324.973 8.18904C314.059 -2.72096 296.301 -2.73696 285.356 8.20857L166.576 126.979L47.806 8.20857C36.876 -2.72143 19.122 -2.74442 8.18904 8.18904C-2.72096 19.103 -2.73696 36.861 8.20857 47.806L126.979 166.576L8.20857 285.356C-2.72143 296.286 -2.74442 314.04 8.18904 324.973C19.103 335.883 36.861 335.899 47.806 324.953L166.576 206.184L285.356 324.953C296.286 335.883 314.04 335.906 324.973 324.973C335.883 314.059 335.899 296.301 324.954 285.356L206.184 166.576Z"
                     fill="currentColor"
                  />
               </svg>
               <router-link to="/" class="font-semibold">Accueil</router-link>
               <!-- Rajouter une condition d'existence de cookie user avant d'afficher le lien ci dessous -->
               <router-link to="/login" v-if="!loggedIn" class="font-semibold">Connexion</router-link>
               <!-- Rajouter une condition d'existence de cookie user avant d'afficher le lien ci dessous -->
               <router-link to="/register" v-if="!loggedIn" class="font-semibold">Inscription</router-link>
               <router-link to="/dashboard" v-if="loggedIn" class="uppercase">Dashboard</router-link>
               <button v-if="loggedIn" @click="disconnect" class="uppercase">Déconnexion</button>
            </ul>
         </nav>
      </div>
   </header>
</template>
