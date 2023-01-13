<template>
  <v-container>
    <v-row>
      <v-col>
        <h1 class="text-h3">{{ stage?.title }}</h1>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <h2 class="text-h4">{{ stage?.information.title }}</h2>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <VueShowdown
          id="markdown-preview"
          :markdown="stage?.information.content"
          :options="{ emoji: true, vueTemplate: true }"
        />
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <h2 class="text-h4">Standorte</h2>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-list lines="two">
          <v-list-item
            v-for="(location, index) in stage?.locations"
            :key="location.id"
          >
            <v-list-item-header>
              <v-list-item-title>{{ location.title }}</v-list-item-title>
              <v-list-item-subtitle
                >{{
                  location.locationMarkers.length
                }}
                Marker</v-list-item-subtitle
              >
            </v-list-item-header>
            <template v-slot:append>
              <v-btn
                variant="plain"
                icon="mdi-delete"
                @click="deleteLocation(location)"
              />
              <!-- <v-menu location="start">
                                <template v-slot:activator="{ props }">
                                    <v-btn
                                        variant="plain"
                                        icon="mdi-dots-vertical"
                                        v-bind="props"
                                    ></v-btn>
                                </template>
                                <v-list density="compact">
                                    <v-list-item
                                        prepend-icon="mdi-pencil"
                                        @click="editLocation(location)"
                                    >
                                        <v-list-item-title>Bearbeiten</v-list-item-title>
                                    </v-list-item>
                                    <v-list-item
                                        prepend-icon="mdi-delete"
                                        @click="deleteLocation(location)"
                                    >
                                        <v-list-item-title>Löschen</v-list-item-title>
                                    </v-list-item>
                                </v-list>
                            </v-menu> -->
            </template>
          </v-list-item>
        </v-list>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-btn @click.stop="showLocationDialog = true"
          >Standort hinzufügen</v-btn
        >
        <LocationDialog
          :initial-location="locationForLocationDialog"
          v-model="showLocationDialog"
          @show-i-beacon-location-marker-dialog="
            (value) => {
              showIBeaconLocationMarkerDialog = value;
            }
          "
          @show-q-r-code-location-marker-dialog="
            (value) => {
              showQRCodeLocationMarkerDialog = value;
            }
          "
          @save-location="saveLocation"
          @update-location="updateLocation"
        />
        <IBeaconLocationMarkerDialog
          v-model="showIBeaconLocationMarkerDialog"
          @update:location-marker="addLocationMarker"
        />
        <QRCodeLocationMarkerDialog
          v-model="showQRCodeLocationMarkerDialog"
          @update:location-marker="addLocationMarker"
        />
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <h2 class="text-h4">Aktivitäten</h2>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-table>
          <thead>
            <tr>
              <th>Titel</th>
              <th>Aktivitätstyp</th>
              <th># Antworten</th>
              <th>Maximalpunktezahl</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="activity in stageActivities">
              <td>{{ activity.title }}</td>
              <td>{{ getActivityTypeName(activity.type) }}</td>
              <td>{{ activity.answers.length }}</td>
              <td>{{ activity.maxPoints }}</td>
              <td class="text-right">
                <v-btn
                  variant="plain"
                  icon="mdi-delete"
                  @click="deleteStageActivity(activity)"
                />
              </td>
            </tr>
          </tbody>
        </v-table>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-btn @click="showStageActivityDialog = true"
          >Aktivität hinzufügen</v-btn
        >
        <StageActivityDialog
          :initial-stage-acitivity="stageActivityForDialog"
          v-model="showStageActivityDialog"
          @save-stage-acitivity="saveStageActivity"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { reactive, ref, watch } from "vue";
import { useRoute } from "vue-router";
import { stageApi } from "../../api/rally/stageApi";
import { locationApi } from "../../api/rally/locationApi";
import { Stage } from "../../models/rally/stage";
import LocationDialog from "../../components/rally/LocationDialog.vue";
import {
  IBeaconLocationMarker,
  LocationMarker,
  QRCodeLocationMarker,
} from "../../models/rally/locationMarker";
import QRCodeLocationMarkerDialog from "../../components/rally/QRCodeLocationMarkerDialog.vue";
import IBeaconLocationMarkerDialog from "../../components/rally/IBeaconLocationMarkerDialog.vue";
import { Location } from "../../models/rally/location";
import StageActivityDialog from "../../components/rally/StageActivityDialog.vue";
import {
  StageActivity,
  StageActivityType,
} from "../../models/rally/stageActivity";
import { stageActivityApi } from "../../api/rally/stageActivityApi";

const props = defineProps({
  stageId: { type: String, required: true },
});

const stage = ref<Stage | null>(null);
const stageActivities = reactive<StageActivity[]>([]);

const showLocationDialog = ref(false);
const showIBeaconLocationMarkerDialog = ref(false);
const showQRCodeLocationMarkerDialog = ref(false);
const showStageActivityDialog = ref(false);

const route = useRoute();

watch(
  () => props.stageId,
  async (stageId: string) => {
    await loadStageData(stageId);
  },
  { immediate: true }
);

const locationForLocationDialog = ref<Location>(new Location("", "", []));
const stageActivityForDialog = ref<StageActivity>(
  new StageActivity("", "", "", 0, StageActivityType.singleChoice, [])
);

function getActivityTypeName(activityType: StageActivityType) {
  switch (activityType) {
    case StageActivityType.singleChoice:
      return "Single Choice";
    case StageActivityType.multipleChoice:
      return "Multiple Choice";
    case StageActivityType.textInput:
      return "Texteingabe";
    default:
      "unbekannt";
  }
}

async function loadStageData(stageId: string) {
  stage.value = await stageApi.getStage(stageId);

  await stageActivityApi.getAll(stageId).then((data) => {
    stageActivities.splice(0, stageActivities.length, ...data);
  });
}

function addLocationMarker(locationMarker: LocationMarker) {
  locationForLocationDialog.value.locationMarkers.push(locationMarker);
}

function saveLocation(location: Location) {
  locationApi.create(props.stageId, location).then((_) => {
    // close dialog
    showLocationDialog.value = false;

    // reload stage data
    loadStageData(props.stageId);
  });
}

function updateLocation(location: Location) {
  locationApi.update(props.stageId, location).then((_) => {
    // close dialog
    showLocationDialog.value = false;

    // reload stage data
    loadStageData(props.stageId);
  });
}

function deleteLocation(location: Location) {
  locationApi.remove(props.stageId, location.id).then((_) => {
    loadStageData(props.stageId);
  });
}

function saveStageActivity(stageActivity: StageActivity) {
  stageActivityApi.create(props.stageId, stageActivity).then((_) => {
    // close dialog
    showStageActivityDialog.value = false;

    // reload stage data
    loadStageData(props.stageId);
  });
}

function deleteStageActivity(stageActivity: StageActivity) {
  stageActivityApi.remove(props.stageId, stageActivity.id).then((_) => {
    loadStageData(props.stageId);
  });
}
</script>

<style lang="scss">
#markdown-preview {
  padding: 15px;
  border: 1px solid black;
  border-radius: 5px;

  list-style-position: inside;

  & ul ul {
    margin-left: 1.5em;
  }
}
</style>
