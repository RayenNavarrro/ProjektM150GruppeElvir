<template>
  <v-navigation-drawer v-model="isNavigationDrawerOpen" permanent>
    <v-list nav>
      <v-list-item
        router-link
        :to="{ name: 'Home' }"
        title="Home"
        value="home"
      />

      <v-list-group>
        <template v-slot:activator="{ props }">
          <v-list-item v-bind="props" title="GIBZ Rallye" value="rally" />
        </template>

        <v-list-item
          router-link
          :to="{ name: 'List rallies' }"
          title="Rallies"
          value="listRallies"
        />

        <v-list-item
          router-link
          :to="{ name: 'List stages' }"
          title="Stages"
          value="listStages"
        />
      </v-list-group>

      <v-list-group>
        <template v-slot:activator="{ props }">
          <v-list-item
            v-bind="props"
            title="Handbuch für Lernende"
            value="studentsManual"
          />
        </template>

        <v-list-item
          router-link
          :to="{ name: 'Students manual' }"
          title="Handbuch anzeigen"
          value="showManual"
        ></v-list-item>
        <v-list-item
          router-link
          :to="{ name: 'New article' }"
          title="Artikel erstellen"
          value="addArticle"
        ></v-list-item>
      </v-list-group>
    </v-list>
  </v-navigation-drawer>
</template>

<script setup lang="ts">
import { ref } from "vue";

const isNavigationDrawerOpen = ref(true);
</script>
