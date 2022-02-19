import React, { FunctionComponent, useMemo, useState } from "react";
import UserContext, { UserInfo } from "context/user";

const UserProvider: FunctionComponent = (props) => {
	const { children } = props;

	const [user, setUser] = useState<UserInfo>();

	return (
		<UserContext.Provider value={{ user, setUser }}>
			{children}
		</UserContext.Provider>
	);
};

export default UserProvider;
