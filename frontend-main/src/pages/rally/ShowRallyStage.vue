<template>
  <v-container>
    <v-row>
      <v-col>
        <h1 class="text-h3">ShowRallyStage</h1>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <p class="body-text-1">
          RallyId: <code>{{ rally?.id }}</code>
        </p>
        <p class="body-text-1">
          RallyStageId: <code>{{ rallyStage?.id }}</code>
        </p>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <h2 class="text-h4">Constraints</h2>
      </v-col>
      <v-col cols="12">
        <v-table>
          <thead>
            <tr>
              <th>Typ</th>
              <th># Conditions</th>
              <th>Additional Information</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="constraint in rallyStage?.constraints"
              @click="showConstraint(constraint)"
            >
              <td>{{ getConstraintTypeLabel(constraint) }}</td>
              <td>{{ constraint.conditions.length }}</td>
              <td>{{ getAdditionalInformation(constraint) }}</td>
              <td>
                <v-btn
                  variant="plain"
                  icon="mdi-delete"
                  @click.stop="deleteConstraint(constraint)"
                ></v-btn>
              </td>
            </tr>
          </tbody>
        </v-table>
      </v-col>
    </v-row>

    <v-form @submit.prevent="saveConstraint">
      <v-row>
        <v-col cols="12">
          <h2 class="text-h4">Add Constraint</h2>
        </v-col>
        <v-col cols="12" class="text-center">
          <v-btn-toggle
            v-model="constraintCreationValues.type"
            mandatory
            variant="outlined"
          >
            <v-btn value="entryPoint"> EntryPoint Constraint </v-btn>
            <v-btn value="predecessor"> Predecessor Constraint </v-btn>
            <v-btn value="successor"> Successor Constraint </v-btn>
            <v-btn value="terminal"> Terminal Constraint </v-btn>
          </v-btn-toggle>
        </v-col>

        <v-col
          cols="12"
          v-if="
            constraintCreationValues.type == 'predecessor' ||
            constraintCreationValues.type == 'successor'
          "
        >
          <v-select
            :label="
              constraintCreationValues.type == 'predecessor'
                ? 'Predecessor'
                : 'Successor'
            "
            :items="rallyStageSelectItems"
            v-model="constraintCreationValues.rallyStageId"
          />
        </v-col>

        <v-col cols="12" v-if="constraintCreationValues.type == 'predecessor'">
          <v-checkbox
            label="Immediate predecessor"
            v-model="constraintCreationValues.immediate"
          />
        </v-col>

        <v-col cols="12" class="text-center">
          <v-btn type="submit">Save Constraint</v-btn>
        </v-col>
      </v-row>
    </v-form>
  </v-container>
</template>

<script setup lang="ts">
import { computed, onMounted, reactive, ref, watch } from "vue";
import {
  Constraint,
  EntryPointConstraint,
  PredecessorConstraint,
  Rally,
  RallyStage,
  SuccessorConstraint,
  TerminalConstraint,
} from "../../models/rally/rally";
import { rallyApi } from "../../api/rally/rallyApi";
import { stageApi } from "../../api/rally/stageApi";
import { Stage } from "../../models/rally/stage";
import { constraintApi } from "../../api/rally/constraintApi";
import router from "../../plugins/router";

const props = defineProps({
  rallyId: { type: String, required: true },
  rallyStageId: { type: String, required: true },
});

const rally = ref<Rally | null>(null);
const rallyStage = ref<RallyStage | null>(null);

const stages = reactive<Stage[]>([]);

const constraintCreationValues = reactive({
  type: "",
  rallyStageId: "",
  immediate: false,
});

const rallyStageSelectItems = computed<any>(() => {
  return rally.value?.rallyStages.map((rallyStage) => {
    const stage = stages.find((stage) => stage.id == rallyStage.stageId);
    return {
      title: stage?.title,
      value: rallyStage.id,
    };
  });
});

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

watch(
  () => props.rallyStageId,
  async (rallyStageId: string) => {
    await loadRallyStage(rallyStageId);
  },
  { immediate: true }
);

async function loadRally(rallyId: string) {
  rally.value = await rallyApi.getRally(rallyId);
}

async function loadRallyStage(rallyStageId: string) {
  rallyStage.value = await rallyApi.getRallyStage(props.rallyId, rallyStageId);
}

function getConstraintTypeLabel(constraint: Constraint): string {
  if (constraint.type == "entryPoint") return "Entry Point";

  if (constraint.type == "predecessor") return "Predecessor";

  if (constraint.type == "successor") return "Successor";

  if (constraint.type == "terminal") return "Terminal";

  return "unknown";
}

function getAdditionalInformation(constraint: Constraint): string {
  if (constraint.type == "predecessor") {
    const predecessorConstraint = constraint as PredecessorConstraint;
    let output = getStageTitle(predecessorConstraint.predecessorId);
    output += predecessorConstraint.immediate ? " [immediate]" : "";
    return output;
  }

  if (constraint.type == "successor") {
    const successorConstraint = constraint as SuccessorConstraint;
    return getStageTitle(successorConstraint.successorId);
  }

  return " - ";
}

function getStageTitle(rallyStageId: string): string {
  const rallyStage = rally.value?.rallyStages.find(
    (rallyStage) => rallyStage.id == rallyStageId
  );
  const stage = stages.find((stage) => stage.id == rallyStage?.stageId);
  return stage?.title ?? "";
}

function saveConstraint() {
  const payload = Constraint.BuildConstraint(
    constraintCreationValues.type,
    [],
    constraintCreationValues.rallyStageId,
    constraintCreationValues.immediate
  );
  constraintApi.create(props.rallyId, props.rallyStageId, payload).then((_) => {
    loadRallyStage(props.rallyStageId);
  });
}

function deleteConstraint(constraint: Constraint) {
  constraintApi
    .remove(props.rallyId, props.rallyStageId, constraint.id)
    .then((_) => loadRallyStage(props.rallyStageId));
}

function showConstraint(constraint: Constraint) {
  router.push({
    name: "Show constraint",
    params: {
      rallyId: props.rallyId,
      rallyStageId: props.rallyStageId,
      constraintId: constraint.id,
    },
  });
}
</script>
