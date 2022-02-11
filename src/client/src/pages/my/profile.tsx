import React, { FunctionComponent, useCallback } from "react";
import useSWR from "swr";

import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import NavTemplate from "components/templates/NavTemplate";
import MyPageTemplate from "components/templates/MyPageTemplate";
import { StyledTitle, StyledH3 } from "components/organisms/ProductWish";
import { fetcherWithToken } from "lib/fetcher";
import { UserInfo } from "types";
import UserDetail from "components/molecules/UserDetail";
import ProfileEdit from "components/organisms/ProfileEdit";

const MyTradeBuying: FunctionComponent = () => {
	const { data: myInfo, mutate } = useSWR<UserInfo>(
		`${process.env.END_POINT_USER}/users/me`,
		fetcherWithToken,
	);

	const onHandleChangeImage = () => {};

	const onHandleRemoveImage = () => {};

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
