import axios, { AxiosInstance } from "axios";
import { getToken } from "utils/token";

export const customAxios: AxiosInstance = axios.create({
	baseURL: `${process.env.END_POINT_USER}`,
	headers: {
		Authorization: `Bearer ${getToken("accessToken")}`,
	},
});
