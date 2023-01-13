<template>
  <v-row>
    <v-col>
      <h1 class="text-h2">{{ title }}</h1>
    </v-col>
  </v-row>
</template>

<script setup lang="ts">
import { defineProps } from "vue";

const props = defineProps({
  title: { type: String, required: true },
});
</script>
