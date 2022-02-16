import React, {
	FunctionComponent,
	useCallback,
	useContext,
	useEffect,
	useState,
} from "react";
import Link from "next/link";
import { useRouter } from "next/router";
import axios from "axios";
import useSWR from "swr";

import HeaderTopItem from "components/atoms/HeaderTopItem";
import { UserInfo } from "types";
import { fetcherWithToken } from "lib/fetcher";
import { getToken } from "lib/token";
import colors from "colors/color";
import UserContext from "context/user";

import Swal from "sweetalert2";
import styled from "@emotion/styled";

const HeaderTop: FunctionComponent = () => {
	const router = useRouter();

	const { setUser } = useContext(UserContext);

	/** For Code Review
	 * 아래의 useSWR 토잇ㄴ을 통해 토큰정보를 확인합니다.
	 * 2번째 인자로 넘어간 fetcherWithToken을 통해서 인증이 본격적으로 수행됩니다.
	 */
	const { data: myInfo } = useSWR<UserInfo>(
		`${process.env.END_POINT_USER}/users/me`,
		fetcherWithToken,
		{
			focusThrottleInterval: 60000,
			errorRetryInterval: 60000,
		},
	);

	const [islogin, setIsLogin] = useState<boolean>(false);

	const onLogout = useCallback(async () => {
		const token = getToken("accessToken");
		try {
			const res = await axios.post(
				`${process.env.END_POINT_USER}/users/logout`,
				{},
				{
					headers: {
						Authorization: `Bearer ${token}`,
					},
				},
			);
			if (res.status === 200) {
				// user logout OK.
				window.localStorage.removeItem("creamAccessToken");
				window.localStorage.removeItem("creamRefreshToken");
				Swal.fire({
					position: "top",
					icon: "success",
					html: `로그아웃 되었습니다!`,
					showConfirmButton: true,
					didClose: () => router.reload(),
				});
			}
		} catch (e) {
			console.error("STH wrong when user logout.");
			console.log(e.response);
		}
		router.push("/");
	}, []);

	/** For Code Review
	 * useSWR를 통해서 받아온 데이터인 myInfo가 존재한다면, 로그인 상태로 변경해주고,
	 * context api에 저장되는 유저 아이디 값에 아이디를 저장해줍니다.
	 */
	useEffect(() => {
		if (myInfo) {
			setIsLogin(true);
			setUser({ id: myInfo.id });
		} else {
			setIsLogin(false);
		}
	}, [myInfo]);

	return (
		<HeaderTopWrapper>
			<Link href={"https://hackmd.io/team/sglemonade?nav=overview"}>
				<a>
					<HeaderTopItem>우리들 이야기</HeaderTopItem>
				</a>
			</Link>
			{!islogin ? (
				<Link href={"/login"}>
					<a>
						<HeaderTopItem>관심상품</HeaderTopItem>
					</a>
				</Link>
			) : (
				<Link href={"/my/wish"}>
					<a>
						<HeaderTopItem>관심상품</HeaderTopItem>
					</a>
				</Link>
			)}
			{!islogin ? (
				<Link href={"/login"}>
					<a>
						<HeaderTopItem>마이페이지</HeaderTopItem>
					</a>
				</Link>
			) : (
				<Link href={"/my"}>
					<a>
						<HeaderTopItem>마이페이지</HeaderTopItem>
					</a>
				</Link>
			)}
			{!islogin ? (
				<Link href={"/login"}>
					<a>
						<HeaderTopItem>로그인</HeaderTopItem>
					</a>
				</Link>
			) : (
				<HeaderTopItem style={{ marginLeft: "24px" }} onClick={onLogout}>
					로그아웃
				</HeaderTopItem>
			)}
		</HeaderTopWrapper>
	);
};

export default HeaderTop;

const HeaderTopWrapper = styled.header`
	display: flex;
	padding: 8px 40px;
	align-items: center;
	justify-content: flex-end;
	margin-left: auto;
	> a {
		margin-left: 24px;
	}
	border-bottom: 1px solid ${colors.colors.border};
`;
