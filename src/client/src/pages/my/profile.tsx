import React, { FunctionComponent, useCallback, useContext } from "react";
import useSWR from "swr";
import { useRouter } from "next/router";
import UserContext from "context/user";

import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import NavTemplate from "components/templates/NavTemplate";
import MyPageTemplate from "components/templates/MyPageTemplate";
import { StyledTitle, StyledH3 } from "components/organisms/ProductWish";
import UserDetail from "components/molecules/UserDetail";
import ProfileEdit from "components/organisms/ProfileEdit";
import { fetcherWithToken } from "lib/fetcher";
import { onPatchUserInfo } from "utils/patch";
import { UserInfo } from "types";

const MyTradeBuying: FunctionComponent = () => {
	const router = useRouter();
	const { user } = useContext(UserContext);

	const { data: myInfo, mutate } = useSWR<UserInfo>(
		`${process.env.END_POINT_USER}/users/me`,
		fetcherWithToken,
		{
			focusThrottleInterval: 60000,
			errorRetryInterval: 60000,
		},
	);

	const onHandleChangeImage = useCallback(async () => {
		const id = user.id;
		const imageUrl = "";
		const res = await onPatchUserInfo(id, { profileImageUrl: `${imageUrl}` });
		if (res) {
			mutate();
		} else {
			router.push("/login");
		}
	}, [user]);

	const onHandleRemoveImage = useCallback(async () => {
		const id = user.id;
		const res = await onPatchUserInfo(id, { profileImageUrl: "" });
		if (res) {
			mutate();
		} else {
			router.push("/login");
		}
	}, [user]);

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<MyPageTemplate>
				<StyledTitle>
					<StyledH3>프로필 정보</StyledH3>
				</StyledTitle>
				{myInfo && (
					<UserDetail
						category="put"
						imgSrc={myInfo.profileImageUrl}
						userName={myInfo.name}
						onChangeImage={onHandleChangeImage}
						onRemoveImage={onHandleRemoveImage}
					/>
				)}
				{myInfo && (
					<ProfileEdit
						email={myInfo.email}
						name={myInfo.name}
						address={myInfo.address}
						shoeSize={myInfo.shoeSize.toString()}
					/>
				)}
			</MyPageTemplate>
		</NavTemplate>
	);
};

export default MyTradeBuying;
