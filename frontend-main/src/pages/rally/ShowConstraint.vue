<template>
  <v-container>
    <v-row>
      <v-col>
        <h1 class="text-h3">Show Constraint</h1>
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
        <p class="body-text-1">
          ConstraintId: <code>{{ constraint?.id }}</code>
        </p>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <h2 class="text-h4">Conditions</h2>
      </v-col>
      <v-col cols="12">
        <v-table>
          <thead>
            <tr>
              <th>Typ</th>
              <th>Matching Type</th>
              <th>Additional Information</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="condition in constraint?.conditions">
              <td>{{ getConditionTypeLabel(condition) }}</td>
              <td>{{ getMatchingTypeLabel(condition) }}</td>
              <td>{{ getAdditionalInformation(condition) }}</td>
              <td>
                <v-btn
                  variant="plain"
                  icon="mdi-delete"
                  @click="deleteCondition(condition)"
                ></v-btn>
              </td>
            </tr>
          </tbody>
        </v-table>
      </v-col>
    </v-row>

    <v-form @submit.prevent="saveCondition">
      <v-row>
        <v-col cols="12">
          <h2 class="text-h4">Add Condition</h2>
        </v-col>
        <v-col cols="12" class="text-center">
          <v-btn-toggle
            v-model="conditionCreationValues.type"
            mandatory
            variant="outlined"
          >
            <v-btn value="locationCondition"> Location Condition </v-btn>
            <v-btn value="stageCondition"> Stage Condition </v-btn>
          </v-btn-toggle>
        </v-col>

        <v-col cols="12" class="text-center">
          <v-btn-toggle
            v-model.number="conditionCreationValues.matchingType"
            mandatory
            variant="outlined"
          >
            <v-btn :value="0">Positive Match</v-btn>
            <v-btn :value="1">Negative Match</v-btn>
          </v-btn-toggle>
        </v-col>

        <v-col cols="12">
          <v-select
            v-if="conditionCreationValues.type == 'locationCondition'"
            label="Location"
            :items="locationSelectItems"
            v-model="conditionCreationValues.locationId"
          />
          <v-select
            v-if="conditionCreationValues.type == 'stageCondition'"
            label="Stage"
            :items="stageSelectItems"
            v-model="conditionCreationValues.stageId"
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
  Condition,
  ConditionMatchingType,
  Constraint,
  LocationCondition,
  Rally,
  RallyStage,
  StageCondition,
} from "../../models/rally/rally";
import { rallyApi } from "../../api/rally/rallyApi";
import { constraintApi } from "../../api/rally/constraintApi";
import { conditionApi } from "../../api/rally/conditionApi";
import { stageApi } from "../../api/rally/stageApi";
import { Location } from "../../models/rally/location";
import { Stage } from "../../models/rally/stage";
import { locationApi } from "../../api/rally/locationApi";

const props = defineProps({
  rallyId: { type: String, required: true },
  rallyStageId: { type: String, required: true },
  constraintId: { type: String, required: true },
});

const rally = ref<Rally | null>(null);
const rallyStage = ref<RallyStage | null>(null);
const constraint = ref<Constraint | null>(null);

const stages = reactive<Stage[]>([]);
const locations = reactive<Location[]>([]);

const conditionCreationValues = reactive({
  type: "locationCondition",
  matchingType: ConditionMatchingType.positiveMatch,
  locationId: "",
  stageId: "",
  immediate: false,
});

const stageSelectItems = computed<any>(() => {
  return stages.map((stage) => {
    return { title: stage.title, value: stage.id };
  });
});

const locationSelectItems = computed<any>(() => {
  return locations.map((location) => {
    return { title: location.title, value: location.id };
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

watch(
  () => props.constraintId,
  async (constraintId: string) => {
    await loadConstraint(constraintId);
  },
  { immediate: true }
);

async function loadRally(rallyId: string) {
  rally.value = await rallyApi.getRally(rallyId);
}

async function loadRallyStage(rallyStageId: string) {
  await rallyApi
    .getRallyStage(props.rallyId, rallyStageId)
    .then((rallyStageData) => {
      rallyStage.value = rallyStageData;
      return rallyStageData.stageId;
    })
    .then((_) => {
      return locationApi.getGloballyAll();
    })
    .then((locationData) => locations.push(...locationData));
}

async function loadConstraint(constraintId: string) {
  constraint.value = await constraintApi.getConstraint(
    props.rallyId,
    props.rallyStageId,
    constraintId
  );
}

function getConditionTypeLabel(condition: Condition): string {
  if (condition.hasOwnProperty("locationId")) {
    return "Location Condition";
  }

  if (condition.hasOwnProperty("stageId")) {
    return "Stage Condition";
  }

  return "unknown";
}

function getMatchingTypeLabel(condition: Condition): string {
  if (condition.matchingType == ConditionMatchingType.positiveMatch) {
    return "Positive Match";
  }

  if (condition.matchingType == ConditionMatchingType.negativeMatch) {
    return "Negative Match";
  }

  return "unknown";
}

function getAdditionalInformation(condition: Condition): string {
  if (condition.hasOwnProperty("locationId")) {
    const locationCondition = condition as LocationCondition;
    const location = locations.find(
      (loc) => loc.id == locationCondition.locationId
    );
    return location?.title ?? "Unknown location";
  }

  if (condition.hasOwnProperty("stageId")) {
    const stageCondition = condition as StageCondition;
    const stage = stages.find((s) => s.id == stageCondition.stageId);
    return stage?.title ?? "Unknown stage";
  }

  return "No details available";
}

function saveCondition() {
  let payload: Condition | null = null;
  if (conditionCreationValues.type == "locationCondition") {
    payload = new LocationCondition(
      "",
      conditionCreationValues.matchingType,
      conditionCreationValues.locationId
    );
  } else if (conditionCreationValues.type == "stageCondition") {
    payload = new StageCondition(
      "",
      conditionCreationValues.matchingType,
      conditionCreationValues.stageId
    );
  }

  if (payload != null) {
    conditionApi
      .create(props.rallyId, props.rallyStageId, props.constraintId, payload)
      .then((_) => {
        loadConstraint(props.constraintId);
      });
  }
}

function deleteCondition(condition: Condition) {
  conditionApi
    .remove(props.rallyId, props.rallyStageId, props.constraintId, condition.id)
    .then((_) => loadConstraint(props.constraintId));
}
</script>
