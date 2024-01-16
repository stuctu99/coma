package com.coma.organization.service;

import org.springframework.stereotype.Service;

import com.coma.organization.dao.OrganizationDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrganizationServiceImpl implements OrganizationService {
	private final OrganizationDao dao;
}
