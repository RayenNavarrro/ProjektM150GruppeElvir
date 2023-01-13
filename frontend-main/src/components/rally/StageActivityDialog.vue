<template>
  <v-dialog v-model="showDialog" :retain-focus="false" persistent scrollable>
    <v-form
      ref="stageAcitivityForm"
      v-model="isValidForm"
      @submit.prevent="submitStageActivity"
    >
      <v-card width="750px" max-height="750px">
        <v-card-title>
          <span class="text-h5">Neue Aktivität</span>
        </v-card-title>
        <v-divider />
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  label="Titel"
                  required
                  v-model="stageActivity.title"
                  :rules="[
                    (v) =>
                      !!v || 'Der Titel der Aktivität darf nicht leer sein.',
                  ]"
                />
              </v-col>

              <v-col cols="12">
                <v-textarea
                  label="Aufgabenstellung"
                  v-model="stageActivity.task"
                  :rules="[
                    (v) => !!v || 'Die Aufgabenstellung darf nicht leer sein.',
                  ]"
                ></v-textarea>
              </v-col>

              <v-col cols="12">
                <VueShowdown
                  id="markdown-preview"
                  :markdown="stageActivity.task"
                  :options="{ emoji: true, vueTemplate: true }"
                />
              </v-col>

              <v-col cols="12">
                <v-text-field
                  label="Maximale Punktezahl"
                  required
                  type="number"
                  v-model="stageActivity.maxPoints"
                  :rules="[
                    (v) =>
                      v > -1 ||
                      'Die maximale Punktezahl darf nicht negativ sein.',
                  ]"
                />
              </v-col>

              <v-col>
                <v-select
                  label="Fragetyp"
                  :items="typeOptions"
                  v-model="stageActivity.type"
                />
              </v-col>

              <v-col cols="12">
                <span class="text-h6">Antworten</span>
              </v-col>

              <v-col>
                <v-list select-strategy="leaf">
                  <v-list-item
                    v-for="(answer, index) in stageActivity.answers"
                    :key="index"
                  >
                    <template v-slot:default>
                      <v-list-item-avatar start>
                        <v-checkbox
                          :key="index"
                          hide-details
                          v-model="answer.isCorrect"
                        />
                      </v-list-item-avatar>
                      <v-list-item-header>
                        <v-list-item-title>{{
                          answer.answerText
                        }}</v-list-item-title>
                      </v-list-item-header>
                    </template>
                  </v-list-item>
                </v-list>
              </v-col>

              <v-col cols="12">
                <v-form ref="answerForm" @submit.prevent="submitAnswerForm">
                  <v-text-field
                    label="Neue Antwort"
                    v-model="newAnswer.answerText"
                  >
                    <template v-slot:prepend>
                      <v-checkbox v-model="newAnswer.isCorrect" hide-details />
                    </template>
                    <template v-slot:appendInner>
                      <v-icon class="clickable-icon" @click="submitAnswerForm"
                        >mdi-send</v-icon
                      >
                    </template>
                  </v-text-field> </v-form
                >"
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-divider />
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn variant="text" @click="cancel"> Abbrechen </v-btn>
          <v-btn
            type="submit"
            color="primary"
            variant="text"
            @click="submitStageActivity"
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
import {
  StageActivity,
  StageActivityAnswer,
  StageActivityType,
} from "../../models/rally/stageActivity";

const props = defineProps({
  value: { type: Boolean, required: false, default: false },
  initialStageAcitivity: {
    type: Object as PropType<StageActivity>,
    required: false,
    default: new StageActivity(
      "",
      "",
      "",
      0,
      StageActivityType.singleChoice,
      []
    ),
  },
});

const emit = defineEmits<{
  (e: "update:modelValue", value: boolean): void;
  (e: "saveStageAcitivity", location: StageActivity): void;
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
  () => props.initialStageAcitivity,
  (newInitialStageActivity: StageActivity) => {
    stageActivity.value = newInitialStageActivity;
  }
);

const isValidForm = ref(true);
const stageAcitivityForm = ref<HTMLFormElement | null>(null);

const stageActivity = ref<StageActivity>(props.initialStageAcitivity);
const newAnswer = ref<StageActivityAnswer>(
  new StageActivityAnswer("", "", false)
);

const typeOptions: any[] = [
  { title: "Single Choice", value: StageActivityType.singleChoice },
  { title: "Multiple Choice", value: StageActivityType.multipleChoice },
  { title: "Texteingabe", value: StageActivityType.textInput },
];

function cancel() {
  clearData();
  emit("update:modelValue", false);
}

function clearData() {
  stageActivity.value = new StageActivity(
    "",
    "",
    "",
    0,
    StageActivityType.singleChoice,
    []
  );
}

async function submitStageActivity() {
  const validationResult = await stageAcitivityForm.value?.validate();
  if (validationResult.valid) {
    emit("saveStageAcitivity", stageActivity.value);
    clearData();
  }
}

function submitAnswerForm() {
  stageActivity.value.answers.push(newAnswer.value);
  newAnswer.value = new StageActivityAnswer("", "", false);
}
</script>

<style lang="scss">
.clickable-icon {
  pointer-events: auto;
  cursor: pointer;
}

.v-input__prepend {
  padding-top: 0;
}
</style>
