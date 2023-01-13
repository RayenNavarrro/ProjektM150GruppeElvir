<template>
  <v-form
    ref="assignmentForm"
    v-model="isValidForm"
    @submit.prevent="submitAssignment"
  >
    <v-container>
      <v-row>
        <v-col>
          <v-text-field label="Add new Cohort" v-model="model.audience.title">
            <template v-slot:appendInner>
              <v-icon class="clickable-icon" @click="submitAssignment"
                >mdi-send</v-icon
              >
            </template>
          </v-text-field>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script setup lang="ts">
import { reactive, ref } from "vue";
import { assignmentApi } from "../../api/rally/assignmentApi";
import { Assignment, Audience } from "../../models/rally/assignment";

const props = defineProps({
  rallyId: { type: String, required: true },
});

const emit = defineEmits<{
  (e: "addedNewAssignment"): void;
}>();

const assignmentForm = ref<HTMLFormElement | null>(null);
const isValidForm = ref(true);
const model = reactive<Assignment>(
  new Assignment("", 0, new Audience("", "", []))
);

async function submitAssignment() {
  const validationResult = await assignmentForm.value?.validate();
  if (validationResult.valid) {
    assignmentApi
      .create(props.rallyId, model)
      .then((_) => emit("addedNewAssignment"));
  }
}
</script>

<style lang="scss">
.clickable-icon {
  pointer-events: auto;
  cursor: pointer;
}
</style>
