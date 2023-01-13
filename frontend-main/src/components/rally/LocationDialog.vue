<template>
  <v-dialog v-model="showDialog" :retain-focus="false" persistent>
    <v-form
      ref="locationForm"
      v-model="isValidForm"
      @submit.prevent="submitLocation"
    >
      <v-card width="750px">
        <v-card-title>
          <span class="text-h5">Neuer Standort</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  label="Titel"
                  required
                  v-model="location.title"
                  :rules="[
                    (v) =>
                      !!v || 'Der Titel des Standortes darf nicht leer sein.',
                  ]"
                ></v-text-field>
              </v-col>
              <v-col cols="12">
                <span class="text-h6">Standort-Marker</span>
              </v-col>
              <v-col cols="12" class="text-center">
                <p v-if="location.locationMarkers.length == 0">
                  Für diesen Standort wurden noch keine Standort-Marker erfasst.
                </p>
                <v-list v-else density="compact">
                  <v-list-item
                    v-for="(locationMarker, index) in location.locationMarkers"
                    :key="index"
                  >
                    <template v-if="locationMarker.hasOwnProperty('uuid')">
                      <v-list-item-avatar
                        icon="mdi-bluetooth"
                      ></v-list-item-avatar>
                      <v-list-item-title>
                        UUID:
                        <code>{{
                          (locationMarker as IBeaconLocationMarker).uuid
                        }}</code>
                      </v-list-item-title>
                    </template>
                    <template v-if="locationMarker.hasOwnProperty('content')">
                      <v-list-item-avatar
                        icon="mdi-qrcode"
                      ></v-list-item-avatar>
                      <v-list-item-title>
                        QR-Code Inhalt:
                        <code>{{
                          (locationMarker as QRCodeLocationMarker).content
                        }}</code>
                      </v-list-item-title>
                    </template>
                  </v-list-item>
                </v-list>
              </v-col>
            </v-row>
          </v-container>
          <v-container class="location-marker-form">
            <v-row>
              <v-col
                class="d-flex justify-center align-baseline"
                style="gap: 1rem"
              >
                <v-btn
                  variant="outlined"
                  size="small"
                  prepend-icon="mdi-plus"
                  @click="$emit('showIBeaconLocationMarkerDialog', true)"
                >
                  iBeacon Marker
                </v-btn>
                <v-btn
                  variant="outlined"
                  size="small"
                  prepend-icon="mdi-plus"
                  @click="$emit('showQRCodeLocationMarkerDialog', true)"
                >
                  QR Code Marker
                </v-btn>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn variant="text" @click="cancel"> Abbrechen </v-btn>
          <v-btn
            type="submit"
            color="primary"
            variant="text"
            @click="submitLocation"
          >
            Speichern
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-form>
  </v-dialog>
</template>

<script setup lang="ts">
import { computed, PropType, ref, watch } from "vue";
import { Location } from "../../models/rally/location";
import {
  IBeaconLocationMarker,
  QRCodeLocationMarker,
} from "../../models/rally/locationMarker";

const props = defineProps({
  value: { type: Boolean, required: false, default: false },
  initialLocation: {
    type: Object as PropType<Location>,
    required: false,
    default: new Location("", "", []),
  },
});

const emit = defineEmits<{
  (e: "update:modelValue", value: boolean): void;
  (e: "showIBeaconLocationMarkerDialog", value: boolean): void;
  (e: "showQRCodeLocationMarkerDialog", value: boolean): void;
  (e: "saveLocation", location: Location): void;
}>();

const showDialog = computed({
  get() {
    return props.value;
  },
  set(value) {
    emit("update:modelValue", value);
  },
});

watch(
  () => props.initialLocation,
  (newInitialLocation: Location) => {
    location.value = newInitialLocation;
  }
);

const locationForm = ref<HTMLFormElement | null>(null);
const isValidForm = ref(true);

const location = ref<Location>(props.initialLocation);

function cancel() {
  clearData();
  emit("update:modelValue", false);
}
async function submitLocation() {
  const validationResult = await locationForm.value?.validate();
  if (validationResult.valid) {
    emit("saveLocation", location.value);
    clearData();
  }
}

function clearData() {
  location.value = new Location("", "", []);
}
</script>
