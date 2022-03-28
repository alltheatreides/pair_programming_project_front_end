import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import HomePage from '../views/HomePage.vue'
import LoginPage from '../views/LoginPage.vue'
import RegisterPage from '../views/RegisterPage.vue'
import DashboardPage from '../views/DashboardPage.vue'
import NotFound from '../views/NotFound.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      // component: HomeView
      component: HomePage
    },
    {
      path: '/login',
      name: 'login',

      component: LoginPage
    },
    {
      path: '/register',
      name: 'register',

      component: RegisterPage
    },
    {
      path: '/dashboard',
      name: 'dashboard',

      component: DashboardPage
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue')
    },
    { path: '/404', component: NotFound },

    { path: '/:catchAll(.*)', redirect: '404' },
  ]
})

export default router
