<template>
  <v-container>
    <v-row>
      <v-col>
        <h1 class="text-h3">Neue Rallye erfassen</h1>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-text-field label="Titel der Rallye" v-model="title"></v-text-field>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-btn> Abbrechen </v-btn>
        <v-btn color="primary" @click="submitRallye"> Speichern </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { rallyApi } from "../../api/rally/rallyApi";
import router from "../../plugins/router";

const title = ref("");

function submitRallye(): void {
  rallyApi.create({ title: title.value }).then((rally) => {
    router.push({ name: "Show rally", params: { rallyId: rally.id } });
  });
}
</script>
