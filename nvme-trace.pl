#!/bin/perl

sub parse_del_sq {
	@dwords = split ' ',$_[1];

	$qid = (hex($dwords[1]) << 8) | (hex($dwords[0]));

	print $_[0] . "nvme_admin_delete_sq qid=$qid)\n";
}

sub parse_create_sq {
	@dwords = split ' ',$_[1];

	$sqid = (hex($dwords[1]) << 8) | (hex($dwords[0]));
	$qsize = (hex($dwords[3]) << 8) | (hex($dwords[2]));
	$flags = (hex($dwords[5]) << 8) | (hex($dwords[4]));
	$cqid = (hex($dwords[7]) << 8) | (hex($dwords[6]));
	$nvmsetid = (hex($dwords[9]) << 8) | (hex($dwords[8]));

	print $_[0] . "nvme_admin_create_sq sqid=$sqid, qsize=$qsize, sq_flags=$flags, cqid=$cqid, nvmsetid=$nvmsetid)\n";
}

sub parse_get_log {
	@dwords = split ' ',$_[1];

	$lid = hex($dwords[0]);
	$lsp = hex($dwords[1]) & 0xf;
	$rae = hex($dwords[1]) >> 7;
	$numdl = (hex($dwords[3]) << 8) | (hex($dwords[2]));
	$numdu = (hex($dwords[5]) << 8) | (hex($dwords[4]));
	$lsi = (hex($dwords[7]) << 8) | (hex($dwords[6]));
	$lpol = (hex($dwords[11]) << 24) | (hex($dwords[10]) << 16) | (hex($dwords[9]) << 8) | hex($dwords[8]);
	$lpou = (hex($dwords[15]) << 24) | (hex($dwords[14]) << 16) | (hex($dwords[13]) << 8) | hex($dwords[12]);
	$uuidx = hex($dwords[16]) & 0x3f;

	print $_[0] . "nvme_admin_get_log_page lid=$lid, lsp=$lsp, rae=$rae, numdl=$numdl, numdu=$numdu, lsi=$lsi, lpol=$lpol, lpou=$lpou, uuidx=$uuidx)\n";
}

sub parse_del_cq {
	@dwords = split ' ',$_[1];

	$qid = (hex($dwords[0]) << 8) | (hex($dwords[1]));

	print $_[0] . "nvme_admin_delete_cq cqid=$qid)\n";
}

sub parse_create_cq {
	@dwords = split ' ',$_[1];

	$cqid = (hex($dwords[1]) << 8) | (hex($dwords[0]));
	$qsize = (hex($dwords[3]) << 8) | (hex($dwords[2]));
	$flags = (hex($dwords[5]) << 8) | (hex($dwords[4]));
	$irq_vector = (hex($dwords[7]) << 8) | (hex($dwords[6]));

	print $_[0] . "nvme_admin_create_cq cqid=$cqid, qsize=$qsize, cq_flags=$flags, irq_vector=$irq_vector)\n";
}

sub parse_identify {
	@dwords = split ' ',$_[1];

	$ncs = hex($dwords[0]);
	$ctrlid = (hex($dwords[3]) << 8) | (hex($dwords[2]));
	$nvmsetsid = (hex($dwords[5]) << 8) | (hex($dwords[4]));

	print $_[0] . "nvme_admin_identify cns=$cns ctrlid=$ctrlid nvmsetid=$nvmsetid)\n";
}

sub parse_abort {
	@dwords = split ' ',$_[1];

	$cid = (hex($dwords[1]) << 8) | (hex($dwords[0]));
	$sqid = (hex($dwords[3]) << 8) | (hex($dwords[2]));

	print $_[0] . "nvme_admin_abort cid=$cid sqid=$sqid)\n";
}

sub parse_set_features {
	@dwords = split ' ',$_[1];

	$fid = hex($dwords[0]);
	$sv = (hex($dwords[3]) & 0x80) >> 7;
	$uuidx = hex($dwords[16]) & 0x3f;

	print $_[0] . "nvme_admin_set_features fid=$fid, sv=$sv, uuidx=$uuidx)\n";
}

sub parse_get_features {
	@dwords = split ' ',$_[1];

	$fid = hex($dwords[0]);
	$sel = (hex($dwords[1]) & 0x3);
	$cdw11 = (hex($dwords[7]) << 24) | (hex($dwords[6]) << 16) | (hex($dwords[5]) << 8) | hex($dwords[4]);
	$uuidx = hex($dwords[16]) & 0x3f;

	print $_[0] . "nvme_admin_get_features fid=$fid, sv=$sv, cdw11=$cdw11, uuidx=$uuidx)\n";
}

sub parse_aer {
	print $_[0] . "nvme_admin_async_event_request)\n";
}

sub parse_ns_mgmt {
	@dwords = split ' ',$_[1];

	$sel = (hex($dwords[0]) & 0x3);

	print $_[0] . "nvme_admin_ns_mgmt sel=$sel)\n";
}

sub parse_fw_commit {
	@dwords = split ' ',$_[1];

	$fs = (hex($dwords[0]) & 0x7);
	$ca = ((hex($dwords[0]) >> 3) & 0x7);
	$bpid = (hex($dwords[3]) >> 7);

	print $_[0] . "nvme_firmware_commit fs=$fs, ca=$ca, bpid=$bpid)\n";
}

sub parse_fw_download {
	@dwords = split ' ',$_[1];

	$numd = (hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$ofst = (hex($dwords[7]) << 24) | (hex($dwords[6]) << 16) | (hex($dwords[5]) << 8) | hex($dwords[4]);

	print $_[0] . "nvme_firmware_download numd=$numd, ofst=$ofst)\n";
}

sub parse_dst {
	@dwords = split ' ',$_[1];

	$sct = (hex($dwords[0]) & 0xf);

	print $_[0] . "nvme_device_self_test sct=$sct)\n";
}

sub parse_ns_attach {
	@dwords = split ' ',$_[1];

	$sel = (hex($dwords[0]) & 0xf);

	print $_[0] . "nvme_ns_attach sel=$sel)\n";
}

sub parse_ka {
	print $_[0] . "nvme_keep_alive)\n";
}

sub parse_dir_send {
	@dwords = split ' ',$_[1];

	$numd = (hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$doper = (hex($dwords[4]));
	$dtype = (hex($dwords[5]));
	$dspec = (hex($dwords[7]) << 8) | (hex($dwords[6]));

	print $_[0] . "nvme_directive_send numd=$numd, doper=$doper, dtype=$dtype, dspec=$dspec)\n";
}

sub parse_dir_recv {
	@dwords = split ' ',$_[1];

	$numd = (hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$doper = (hex($dwords[4]));
	$dtype = (hex($dwords[5]));
	$dspec = (hex($dwords[7]) << 8) | (hex($dwords[6]));

	print $_[0] . "nvme_directive_receive numd=$numd, doper=$doper, dtype=$dtype, dspec=$dspec)\n";
}

sub parse_virt_mgmt {
	@dwords = split ' ',$_[1];

	$act = (hex($dwords[0]) & 0xf);
	$rt = (hex($dwords[1] & 0x7));
	$cntlid = (hex($dwords[3]) << 8) | (hex($dwords[2]));
	$nr = (hex($dwords[5]) << 8) | (hex($dwords[4]));

	print $_[0] . "nvme_virt_mgmt act=$act, rt=$rt, cntlid=$cntlid nr=$nr)\n";
}

sub parse_db_buf {
	print $_[0] . "nvme_doorbell_buffer_config)\n";
}

sub parse_format {
	@dwords = split ' ',$_[1];

	$lbaf = (hex($dwords[0]) & 0xf);
	$mset = ((hex($dwords[0]) >> 4) & 0x1);
	$pi = (hex($dwords[0]) >> 5);
	$pil = (hex($dwords[1]) & 0x1);
	$ses = ((hex($dwords[1]) >> 1) & 0x7);

	print $_[0] . "nvme_format_nvm lbaf=$lbaf, mset=$mset, pi=$pi, pil=$pil, ses=$ses)\n";
}

sub parse_sec_send {
	@dwords = split ' ',$_[1];

	$nssf = hex($dwords[0]);
	$spsp0 = hex($dwords[1]);
	$spsp1 = hex($dwords[2]);
	$secp = hex($dwords[3]);
	$tl =(hex($dwords[7]) << 24) | (hex($dwords[6]) << 16) | (hex($dwords[5]) << 8) | hex($dwords[3]); 

	print $_[0] . "nvme_security_send nssf=$nssf, spsp0=$spsp0, spsp1=$spsp1, secp=$secp, tl=$tl)\n";
}

sub parse_sec_recv {
	@dwords = split ' ',$_[1];

	$nssf = hex($dwords[0]);
	$spsp0 = hex($dwords[1]);
	$spsp1 = hex($dwords[2]);
	$secp = hex($dwords[3]);
	$al =(hex($dwords[7]) << 24) | (hex($dwords[6]) << 16) | (hex($dwords[5]) << 8) | hex($dwords[4]); 

	print $_[0] . "nvme_security_receive nssf=$nssf, spsp0=$spsp0, spsp1=$spsp1, secp=$secp, al=$al)\n";
}

sub parse_sanitize {
	@dwords = split ' ',$_[1];

	$sanact = (hex($dwords[0]) & 0x7);
	$ause = ((hex($dwords[0]) >> 3) & 0x1);
	$owpass = ((hex($dwords[0]) >> 4) & 0x7);
	$oipbp = (hex($dwords[1]) & 0x1);
	$no_dealloc = ((hex($dwords[1]) >> 1) & 0x1);
	$overpat = (hex($dwords[7]) << 24) | (hex($dwords[6]) << 16) | (hex($dwords[5]) << 8) | hex($dwords[4]); 

	print $_[0] . "nvme_sanitize sanact=$sanact, ause=$ause, owpass=$owpass, oipbp=$oipbp no_dealloc=$no_dealloc, overpat=$overpat)\n";
}

sub parse_get_lba_sts {
	@dwords = split ' ',$_[1];

	$slba = (hex($dwords[7]) << 56) | (hex($dwords[6]) << 48) | (hex($dwords[5]) << 40) | (hex($dwords[4]) << 32) |
		(hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$mndw = (hex($dwords[11]) << 24) | (hex($dwords[10]) << 16) | (hex($dwords[9]) << 8) | hex($dwords[8]);
	$rl = (hex($dwords[13]) << 8) | (hex($dwords[12]));
	$atype = hex($dwords[15]);

	print $_[0] . "nvme_get_lba_status slba=$slba, mndw=$mndw, rl=$rl, atype=$atype)\n";
}

sub parse_admin {
	$_[0] =~ /(^.*cmd=\()(0x.*) cdw10=(.*)\)/;
	$prefix = $1;
	$op = hex($2);
	$dwords = $3;

	if    ($op == 0x00) { parse_del_sq($prefix, $dwords); }
	elsif ($op == 0x01) { parse_create_sq($prefix, $dwords); }
	elsif ($op == 0x02) { parse_get_log($prefix, $dwords); }
	elsif ($op == 0x04) { parse_del_cq($prefix, $dwords); }
	elsif ($op == 0x05) { parse_create_cq($prefix, $dwords); }
	elsif ($op == 0x06) { parse_identify($prefix, $dwords); }
	elsif ($op == 0x08) { parse_abort($prefix, $dwords); }
	elsif ($op == 0x09) { parse_set_features($prefix, $dwords); }
	elsif ($op == 0x0a) { parse_get_features($prefix, $dwords); }
	elsif ($op == 0x0c) { parse_aer($prefix, $dwords); }
	elsif ($op == 0x0d) { parse_ns_mgmt($prefix, $dwords); }
	elsif ($op == 0x10) { parse_fw_commit($prefix, $dwords); }
	elsif ($op == 0x11) { parse_fw_download($prefix, $dwords); }
	elsif ($op == 0x14) { parse_dst($prefix, $dwords); }
	elsif ($op == 0x15) { parse_ns_attach($prefix, $dwords); }
	elsif ($op == 0x18) { parse_ka($prefix, $dwords); }
	elsif ($op == 0x19) { parse_dir_send($prefix, $dwords); }
	elsif ($op == 0x1a) { parse_dir_recv($prefix, $dwords); }
	elsif ($op == 0x1c) { parse_virt_mgmt($prefix, $dwords); }
	elsif ($op == 0x7c) { parse_db_buf($prefix, $dwords); }
	elsif ($op == 0x80) { parse_format($prefix, $dwords); }
	elsif ($op == 0x81) { parse_sec_send($prefix, $dwords); }
	elsif ($op == 0x82) { parse_sec_recv($prefix, $dwords); }
	elsif ($op == 0x84) { parse_sanitize($prefix, $dwords); }
	elsif ($op == 0x86) { parse_get_lba_sts($prefix, $dwords); }
	else                { print "$_[0]\n"; }
}

sub parse_flush {
	print $_[0] . "nvme_flush)\n";
}

sub parse_write {
	@dwords = split ' ',$_[1];

	$slba = (hex($dwords[7]) << 56) | (hex($dwords[6]) << 48) | (hex($dwords[5]) << 40) | (hex($dwords[4]) << 32) |
		(hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$nlb = (hex($dwords[9] << 8)) | (hex($dwords[8]));
	$dtype = (hex($dwords[10]) >> 4);
	$prinfo = (hex($dwords[11]) >> 2);
	$fua = (hex($dwords[11]) >> 6) & 0x1;
	$lr = (hex($dwords[11]) >> 7);
	$dsm = hex($dwords[12]);
	$dspec = (hex($dwords[15]) << 8) | (hex($dwords[14]));
	$ilbrt = (hex($dwords[19]) << 24) | (hex($dwords[18]) << 16) | (hex($dwords[17]) << 8) | hex($dwords[16]);
	$lbat = (hex($dwords[21]) << 8) | (hex($dwords[20]));
	$lbatm = (hex($dwords[23]) << 8) | (hex($dwords[22]));

	print $_[0] . "nvme_write slba=$slba, nlb=$nlb, dtype=$dtype, prinfo=$prinfo, fua=$fua, lr=$lr, dsm=$dsm, dspec=$dspec, ilbrt=$ilbrt, lbat=$lbat, lbatm=$lbatm)\n";
}

sub parse_read {
	@dwords = split ' ',$_[1];

	$slba = (hex($dwords[7]) << 56) | (hex($dwords[6]) << 48) | (hex($dwords[5]) << 40) | (hex($dwords[4]) << 32) |
		(hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$nlb = (hex($dwords[9] << 8)) | (hex($dwords[8]));
	$prinfo = (hex($dwords[11]) >> 2);
	$fua = (hex($dwords[11]) >> 6) & 0x1;
	$lr = (hex($dwords[11]) >> 7);
	$dsm = hex($dwords[12]);
	$eilbrt = (hex($dwords[19]) << 24) | (hex($dwords[18]) << 16) | (hex($dwords[17]) << 8) | hex($dwords[16]);
	$elbat = (hex($dwords[21]) << 8) | (hex($dwords[20]));
	$elbatm = (hex($dwords[23]) << 8) | (hex($dwords[22]));

	print $_[0] . "nvme_read slba=$slba, nlb=$nlb, prinfo=$prinfo, fua=$fua, lr=$lr, dsm=$dsm, eilbrt=$eilbrt, elbat=$elbat, elbatm=$elbatm)\n";
}

sub parse_write_uncor {
	@dwords = split ' ',$_[1];

	$slba = (hex($dwords[7]) << 56) | (hex($dwords[6]) << 48) | (hex($dwords[5]) << 40) | (hex($dwords[4]) << 32) |
		(hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$nlb = (hex($dwords[9] << 8)) | (hex($dwords[8]));

	print $_[0] . "nvme_write_uncorrectable slba=$slba, nlb=$nlb)\n";
}

sub parse_cmp {
	@dwords = split ' ',$_[1];

	$slba = (hex($dwords[7]) << 56) | (hex($dwords[6]) << 48) | (hex($dwords[5]) << 40) | (hex($dwords[4]) << 32) |
		(hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$nlb = (hex($dwords[9] << 8)) | (hex($dwords[8]));
	$prinfo = (hex($dwords[11]) >> 2);
	$fua = (hex($dwords[11]) >> 6) & 0x1;
	$lr = (hex($dwords[11]) >> 7);
	$eilbrt = (hex($dwords[19]) << 24) | (hex($dwords[18]) << 16) | (hex($dwords[17]) << 8) | hex($dwords[16]);
	$elbat = (hex($dwords[21]) << 8) | (hex($dwords[20]));
	$elbatm = (hex($dwords[23]) << 8) | (hex($dwords[22]));

	print $_[0] . "nvme_compare slba=$slba, nlb=$nlb, prinfo=$prinfo, fua=$fua, lr=$lr, dsm=$dsm, eilbrt=$eilbrt, elbat=$elbat, elbatm=$elbatm)\n";
}

sub parse_write_zeroes {
	@dwords = split ' ',$_[1];

	$slba = (hex($dwords[7]) << 56) | (hex($dwords[6]) << 48) | (hex($dwords[5]) << 40) | (hex($dwords[4]) << 32) |
		(hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$nlb = (hex($dwords[9] << 8)) | (hex($dwords[8]));
	$deac = (hex($dwords[11]) & 1);
	$prinfo = (hex($dwords[11]) >> 2);
	$fua = (hex($dwords[11]) >> 6) & 0x1;
	$lr = (hex($dwords[11]) >> 7);
	$ilbrt = (hex($dwords[19]) << 24) | (hex($dwords[18]) << 16) | (hex($dwords[17]) << 8) | hex($dwords[16]);
	$lbat = (hex($dwords[21]) << 8) | (hex($dwords[20]));
	$lbatm = (hex($dwords[23]) << 8) | (hex($dwords[22]));

	print $_[0] . "nvme_write_zeroes slba=$slba, nlb=$nlb, deac=$deac, prinfo=$prinfo, fua=$fua, lr=$lr, ilbrt=$ilbrt, lbat=$lbat, lbatm=$lbatm)\n";

	print $_[0] . "nvme_)\n";
}

sub parse_dsm {
	@dwords = split ' ',$_[1];

	$nr = hex($dwords[0]) & 0xff;
	$idr = hex($dwords[4]) & 0x1;
	$idw = (hex($dwords[4]) >> 1) & 0x1;
	$ad = (hex($dwords[4]) >> 2) & 0x1;

	print $_[0] . "nvme_data_set_mgmt nr=$nr, idr=$idr, idw=$idw, ad=$ad)\n";
}

sub parse_verify {
	@dwords = split ' ',$_[1];

	$slba = (hex($dwords[7]) << 56) | (hex($dwords[6]) << 48) | (hex($dwords[5]) << 40) | (hex($dwords[4]) << 32) |
		(hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$nlb = (hex($dwords[9] << 8)) | (hex($dwords[8]));
	$prinfo = (hex($dwords[11]) >> 2);
	$fua = (hex($dwords[11]) >> 6) & 0x1;
	$lr = (hex($dwords[11]) >> 7);
	$eilbrt = (hex($dwords[19]) << 24) | (hex($dwords[18]) << 16) | (hex($dwords[17]) << 8) | hex($dwords[16]);
	$elbat = (hex($dwords[21]) << 8) | (hex($dwords[20]));
	$elbatm = (hex($dwords[23]) << 8) | (hex($dwords[22]));

	print $_[0] . "nvme_verify slba=$slba, nlb=$nlb, prinfo=$prinfo, fua=$fua, lr=$lr, eilbrt=$eilbrt, elbat=$elbat, elbatm=$elbatm)\n";
}

sub parse_resv_reg {
	@dwords = split ' ',$_[1];

	$rrega = hex($dwords[0]) & 0x7;
	$iekey = (hex($dwords[0]) >> 3) & 0x1;
	$cptpl = (hex($dwords[3]) >> 6);

	print $_[0] . "nvme_reservation_register rrega=$rrega, iekey=$iekey, cptpl=$cptpl)\n";
}

sub parse_resv_report {
	@dwords = split ' ',$_[1];

	$numd = (hex($dwords[3]) << 24) | (hex($dwords[2]) << 16) | (hex($dwords[1]) << 8) | hex($dwords[0]);
	$eds = hex($dwords[4]) & 0x1;

	print $_[0] . "nvme_reservation_report numd=$numd, eds=$eds)\n";
}

sub parse_resv_acq {
	@dwords = split ' ',$_[1];

	$racqa = hex($dwords[0]) & 0x7;
	$iekey = (hex($dwords[0]) >> 3) & 0x1;
	$rtype = hex($dwords[1]);

	print $_[0] . "nvme_reservation_acquire racqa=$racqa, iekey=$iekey, rtype=$rtype)\n";
}

sub parse_resv_rel {
	@dwords = split ' ',$_[1];

	$rrela = hex($dwords[0]) & 0x7;
	$iekey = (hex($dwords[0]) >> 3) & 0x1;
	$rtype = hex($dwords[1]);

	print $_[0] . "nvme_reservation_release rrela=$rrela, iekey=$iekey, rtype=$rtype)\n";
}

sub parse_io {
	$_[0] =~ /cmd=\((0x.*)/;
	$op = hex($1);

	if    ($op == 0x00) { parse_flush($_); }
	elsif ($op == 0x01) { parse_write($_); }
	elsif ($op == 0x02) { parse_read($_); }
	elsif ($op == 0x04) { parse_write_uncor($_); }
	elsif ($op == 0x05) { parse_cmp($_); }
	elsif ($op == 0x08) { parse_write_zeroes($_); }
	elsif ($op == 0x09) { parse_dsm($_); }
	elsif ($op == 0x0c) { parse_verify($_); }
	elsif ($op == 0x0d) { parse_resv_reg($_); }
	elsif ($op == 0x0e) { parse_resv_report($_); }
	elsif ($op == 0x11) { parse_resv_acq($_); }
	elsif ($op == 0x15) { parse_resv_rel($_); }
	else                { print "$_[0]\n"; }
}

sub parse_cmd {
	if ($_[0] =~ /cmd=\(0x/) {
		if ($_[0] =~ /qid=0/) {
			parse_admin($_[0]);
		} else {
			parse_io($_[0]);
		}
	} else {
		print "$_[0]\n";
	}
}

while (<>) {
	chomp;
	if ($_ =~ /nvme_setup_cmd/) {
		parse_cmd($_);
	} else {
		print $_ . "\n";
	}
}
