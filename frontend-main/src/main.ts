import { createApp } from "vue";
import { registerPlugins } from '@/plugins'
import { VueShowdownPlugin } from "vue-showdown";

import App from './App.vue';

const app = createApp(App);

registerPlugins(app);

app.use(VueShowdownPlugin, {
    flavor: 'github',
});

app.mount("#app");