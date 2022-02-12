import React, { createContext, SetStateAction } from "react";

export interface UserInfo {
	id: number;
}

type User = {
	user?: UserInfo;
	setUser?: React.Dispatch<SetStateAction<UserInfo | undefined>>;
};

const UserContext = createContext<User>({});

export default UserContext;
