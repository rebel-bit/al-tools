<?php
if(isset($_POST['no'])){
	//apakah data no sudah terkirim?
	$no = htmlspecialchars($_POST['no']);
	
	if(is_numeric($no)){
		$url = "https://www.indihome.co.id/verifikasi-layanan/login-otp";
		
		//pengambilan token
		define("cookie", "cookie.txt");
		
		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_COOKIESESSION, true);
		curl_setopt($ch, CURLOPT_COOKIEJAR, cookie);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_HEADER, true);
		$ch = curl_exec($ch);
		
		preg_match('/name=\"_token\" value\=\"(.*?)\"/', $ch, $token);
		$token = $token[1];
		
		//pengiriman data
		$data = ['msisdn' => $no, '_token' => $token];
		$data = http_build_query($data);
		
		$cb = curl_init($url);
		curl_setopt ($cb, CURLOPT_COOKIEJAR, cookie);
		curl_setopt ($cb, CURLOPT_COOKIEFILE, cookie);
		curl_setopt($cb, CURLOPT_POST, true);
		curl_setopt($cb, CURLOPT_POSTFIELDS, $data);
		curl_setopt ($cb, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($cb, CURLOPT_HEADER, true);
		$cb = curl_exec($cb);
		
		if(file_exists("cookie.txt")) {
			unlink("cookie.txt");
		}
		
		//validation
		if('Pastikan nomor handphone yang anda masukan sudah benar' or 'Kode OTP telah dikirim ke nomor Handphone Anda' == $cb){
			$true['API'] = array(
				'code' => 'true',
				'status'=> 'success',
				'message' => 'Sent to '.$no
			);
		echo json_encode($true);
		}else{
			$error['API'] = array(
				'code' => 'false',
				'status'=> 'error',
				'message' => 'ERROR!'
			);
		echo json_encode($error);
		}
		
		//output
	}else{
		$error['API'] = array(
			'code' => 'false',
			'status'=> 'error',
			'message' => 'Please enter a valid number!'
		);
		echo json_encode($error);
	}
}else{
	$error['API'] = array(
		'code' => 'false',
		'status'=> 'error',
		'message' => 'No data sent!'
	);
	echo json_encode($error);
}
?>
