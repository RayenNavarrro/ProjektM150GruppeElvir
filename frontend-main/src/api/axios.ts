import axios from "axios";

const apiDomain = import.meta.env.GIBZAPP_API_HOST;
const apiBasePath = import.meta.env.GIBZAPP_API_BASE_PATH;
const timeout = import.meta.env.GIBZAPP_API_TIMEOUT;

const axiosInstance = axios.create({
  baseURL: `${apiDomain}${apiBasePath}`,
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
  },
  timeout: typeof timeout !== "number" ? 7500 : timeout,
});

export default axiosInstance;
