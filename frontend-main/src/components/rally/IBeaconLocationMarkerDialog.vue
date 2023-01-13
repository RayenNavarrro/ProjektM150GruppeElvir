<template>
  <v-dialog v-model="showDialog" persistent>
    <v-form
      ref="locationMarkerForm"
      v-model="isValidForm"
      @submit.prevent="submitForm"
    >
      <v-card width="500px">
        <v-card-title>
          <span class="text-h5">QR Code Standord-Marker</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  label="UUID"
                  v-model="iBeaconLocationMarker.uuid"
                  :rules="uuidFormatRules"
                />
              </v-col>
              <v-col cols="6">
                <v-text-field
                  label="Major"
                  v-model.number="iBeaconLocationMarker.major"
                  type="number"
                  :rules="majorMinorRules"
                />
              </v-col>
              <v-col cols="6">
                <v-text-field
                  label="Minor"
                  v-model.number="iBeaconLocationMarker.minor"
                  type="number"
                  :rules="majorMinorRules"
                />
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn variant="text" @click="showDialog = false"> Abbrechen </v-btn>
          <v-btn
            type="submit"
            variant="text"
            color="primary"
            @click="submitForm"
          >
            Speichern
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-form>
  </v-dialog>
</template>

<script setup lang="ts">
import { computed, ref } from "vue";
import { IBeaconLocationMarker } from "../../models/rally/locationMarker";

const props = defineProps({
  modelValue: { type: Boolean, default: false, required: false },
});

const emit = defineEmits<{
  (e: "update:modelValue", value: Boolean): void;
  (e: "update:locationMarker", value: IBeaconLocationMarker): void;
}>();

const showDialog = computed({
  get() {
    return props.modelValue;
  },
  set(value) {
    emit("update:modelValue", value);
  },
});

const uuidFormatRules = [
  (v: string) =>
    /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/.test(v) ||
    "Ungültiges Format für eine UUID.",
];

const majorMinorRules = [
  (v: number) => v <= 65535 || "Der Wert darf nicht grösser als 65'535 sein.",
  (v: number) => v >= 0 || "Der Wert darf nicht kleiner als 0 sein.",
];

const locationMarkerForm = ref<HTMLFormElement | null>(null);
const isValidForm = ref(true);

const iBeaconLocationMarker = ref<IBeaconLocationMarker>({
  id: "",
  uuid: "",
  major: 0,
  minor: 0,
});

async function submitForm() {
  const validationResult = await locationMarkerForm.value?.validate();
  if (validationResult.valid) {
    emit("update:locationMarker", iBeaconLocationMarker.value); // propagate new location marker
    emit("update:modelValue", false); // close dialog
    iBeaconLocationMarker.value = new IBeaconLocationMarker("", "", 0, 0); // reset data
  }
}
</script>
