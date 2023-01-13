<template>
  <v-container>
    <v-row>
      <v-col>
        <h1 class="text-h3">Rallies</h1>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-table fixed-header>
          <thead>
            <tr>
              <th class="text-left">Titel</th>
              <th class="text-left"># Stages</th>
              <th class="text-left"># Assignments</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="rally in rallies"
              :key="rally.id"
              @click="showRally(rally)"
            >
              <td>{{ rally.title }}</td>
              <td>{{ rally.rallyStages.length }}</td>
              <td>{{ rally.assignments.length }}</td>
            </tr>
          </tbody>
        </v-table>
      </v-col>
    </v-row>

    <v-row>
      <v-col class="text-center">
        <v-btn :to="{ name: 'New rally' }" color="primary"
          >Rally erstellen</v-btn
        >
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { onMounted, reactive } from "vue";
import { rallyApi } from "../../api/rally/rallyApi";
import { Rally } from "../../models/rally/rally";
import router from "../../plugins/router";

const rallies: Rally[] = reactive([]);

onMounted(() => {
  fetchData();
});

async function fetchData(): Promise<void> {
  var rallyData = await rallyApi.getAll();
  rallies.splice(0, rallies.length - 1, ...rallyData);
}

function showRally(rally: Rally): void {
  router.push({ name: "Show rally", params: { rallyId: rally.id } });
}
</script>
