<template>
  <v-container>
    <v-row>
      <v-col>
        <h1 class="text-h3">Neue Stage zu Rally hinzufügen</h1>
      </v-col>
    </v-row>
    <v-row v-if="rally">
      <v-col cols="12">
        <p class="text-body-1">
          Wähle die Stage aus, welche zur Rally
          <span class="font-weight-bold">{{ rally!.title }}</span>
          hinzufügen möchtest.
        </p>
      </v-col>
      <v-col cols="12">
        <v-select
          label="Stage"
          v-model="newRallyStage.stageId"
          :items="stageSelectItems"
        />
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-btn> Abbrechen </v-btn>
        <v-btn color="primary" @click="submitRallyStage"> Speichern </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { computed, onMounted, reactive, ref, watch } from "vue";
import { rallyApi } from "../../api/rally/rallyApi";
import { stageApi } from "../../api/rally/stageApi";
import { Rally, RallyStage } from "../../models/rally/rally";
import { Stage } from "../../models/rally/stage";
import router from "../../plugins/router";

const props = defineProps({
  rallyId: { type: String, required: true },
});

const rally = ref<Rally | null>(null);

const newRallyStage = ref<RallyStage>(
  new RallyStage("", props.rallyId, "", [])
);

const stages = reactive<Stage[]>([]);

onMounted(() => {
  stageApi.getAll().then((stageData) => {
    stages.push(...stageData);
  });
});

watch(
  () => props.rallyId,
  async (rallyId: string) => {
    await loadRally(rallyId);
  },
  { immediate: true }
);

const stageSelectItems = computed<any>(() => {
  return stages.map((stage) => {
    return { title: stage.title, value: stage.id };
  });
});

async function loadRally(rallyId: string) {
  rally.value = await rallyApi.getRally(rallyId);
}

function submitRallyStage() {
  rallyApi
    .addRallyStage(props.rallyId, newRallyStage.value)
    .then((newRallyStage) => {
      router.push({
        name: "Show rallyStage",
        params: { rallyId: props.rallyId, rallyStageId: newRallyStage.id },
      });
    });
}
</script>
