<template>
  <v-app>
    <v-app-bar>
      <v-app-bar-nav-icon></v-app-bar-nav-icon>
      <v-app-bar-title>
        <router-link :to="{ name: 'Home' }"> GIBZ Mobile App </router-link>
      </v-app-bar-title>
    </v-app-bar>
    <NavigationDrawer />
    <v-main>
      <RouterView />
    </v-main>
  </v-app>
</template>

<script setup lang="ts">
import NavigationDrawer from "@/components/NavigationDrawer.vue";
</script>

<style lang="scss">
.v-toolbar-title a {
  text-decoration: none;
  color: inherit;
}
</style>
