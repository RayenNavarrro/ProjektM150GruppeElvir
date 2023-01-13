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
                  label="Content"
                  v-model="qrCodeLocationMarker.content"
                  :rules="contentRules"
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
import { QRCodeLocationMarker } from "../../models/rally/locationMarker";

const props = defineProps({
  modelValue: { type: Boolean, default: false, required: false },
});

const emit = defineEmits<{
  (e: "update:modelValue", value: Boolean): void;
  (e: "update:locationMarker", value: QRCodeLocationMarker): void;
}>();

const showDialog = computed({
  get() {
    return props.modelValue;
  },
  set(value) {
    emit("update:modelValue", value);
  },
});

const contentRules = [
  (v: string) => !!v || "Der Inhalt des QR-Codes darf nicht leer sein.",
];

const locationMarkerForm = ref<HTMLFormElement | null>(null);
const isValidForm = ref(true);

const qrCodeLocationMarker = ref<QRCodeLocationMarker>({
  id: "",
  content: "",
});

async function submitForm() {
  const validationResult = await locationMarkerForm.value?.validate();
  if (validationResult.valid) {
    emit("update:locationMarker", qrCodeLocationMarker.value); // propagate new location marker
    emit("update:modelValue", false); // close dialog
    qrCodeLocationMarker.value = new QRCodeLocationMarker("", ""); // reset data
  }
}
</script>
