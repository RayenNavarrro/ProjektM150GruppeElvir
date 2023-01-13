<template>
  <v-container>
    <v-row>
      <v-col>
        <h1 class="text-h3">{{ rally?.title }}</h1>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <h2 class="text-h4">Assignments</h2>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <v-table>
          <thead>
            <tr>
              <th>Kohorte</th>
              <th>Teilnahme-Code</th>
              <th># Teilnahmen</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="assignment in rally?.assignments" :key="assignment.id">
              <td>{{ assignment.audience.title }}</td>
              <td>{{ formattedJoiningCode(assignment.joiningCode) }}</td>
              <td>{{ assignment.audience.participatingParties.length }}</td>
            </tr>
          </tbody>
        </v-table>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <new-assignment
          :rally-id="props.rallyId"
          @added-new-assignment="loadRally(props.rallyId)"
        />
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <h2 class="text-h4">Stages</h2>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <v-table>
          <thead>
            <tr>
              <th>Titel</th>
              <th>Information</th>
              <th># Standorte</th>
              <th># Constraints</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="rallyStage in rally?.rallyStages"
              @click="showRallyStage(rallyStage)"
            >
              <td>{{ stageWithId(rallyStage.stageId)?.title }}</td>
              <td>{{ stageWithId(rallyStage.stageId)?.information.title }}</td>
              <td>{{ stageWithId(rallyStage.stageId)?.locations.length }}</td>
              <td>{{ rallyStage.constraints.length }}</td>
              <td class="text-right">
                <v-btn
                  variant="plain"
                  icon="mdi-delete"
                  @click="deleteRallyStage(rallyStage)"
                />
              </td>
            </tr>
          </tbody>
        </v-table>
      </v-col>

      <v-col cols="12">
        <v-btn
          :to="{ name: 'Add rallyStage', params: { rallyId: props.rallyId } }"
          >Stage hinzufügen</v-btn
        >
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { onMounted, reactive, ref, watch } from "vue";
import { Rally, RallyStage } from "../../models/rally/rally";
import { Stage } from "../../models/rally/stage";
import { rallyApi } from "../../api/rally/rallyApi";
import { stageApi } from "../../api/rally/stageApi";
import router from "../../plugins/router";
import NewAssignment from "./NewAssignment.vue";

const props = defineProps({
  rallyId: { type: String, required: true },
});

const rally = ref<Rally | null>(null);
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

async function loadRally(rallyId: string) {
  rally.value = await rallyApi.getRally(rallyId);
}

function deleteRallyStage(rallyStage: RallyStage) {
  rallyApi
    .deleteRallyStage(props.rallyId, rallyStage.id)
    .then((_) => loadRally(props.rallyId));
}

function stageWithId(stageId: string): Stage | null {
  return stages.find((stage) => stage.id == stageId) || null;
}

function showRallyStage(rallyStage: RallyStage) {
  router.push({
    name: "Show rallyStage",
    params: { rallyId: rallyStage.rallyId, rallyStageId: rallyStage.id },
  });
}

function formattedJoiningCode(joiningCode: number): string {
  const joiningCodeString = joiningCode.toString();
  return (
    joiningCodeString.substring(0, 3) + "-" + joiningCodeString.substring(3)
  );
}
</script>
