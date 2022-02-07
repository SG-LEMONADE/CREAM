import { category_id, priceRange, gender_id, sort_id } from "./filterId";

export const queryMaker = (
	category: string,
	brands: number[],
	collections: string[],
	gender: string,
	price: string,
	sort: string,
) => {
	let query = {};

	if (category) {
		query = { ...query, category: category_id[category] };
	}
	if (brands.length > 0) {
		query = {
			...query,
			brandId: brands.toString(),
		};
	}
	if (collections.length > 0) {
		query = {
			...query,
			collection: collections.toString(),
		};
	}
	if (gender) {
		query = {
			...query,
			gender: gender_id[gender],
		};
	}
	if (price) {
		query = {
			...query,
			...priceRange[price],
		};
	}
	if (sort) {
		query = {
			...query,
			sort: sort_id[sort],
		};
	}
	return query;
};

export const queryStringMaker = (queryObj) => {
	let queryString = "";
	for (const [key, value] of Object.entries(queryObj)) {
		queryString += `${key}=${value}`;
		queryString += "&";
	}
	queryString = queryString.slice(0, -1);
	return queryString;
};
