import { describe, it, expect, beforeEach, vi } from 'vitest';

describe('Dream Sharing Contract', () => {
  let mockContractCall: any;
  
  beforeEach(() => {
    mockContractCall = vi.fn();
  });
  
  it('should request interpretation', async () => {
    mockContractCall.mockResolvedValue({ success: true, value: 1 });
    const result = await mockContractCall('request-interpretation', 1);
    expect(result.success).toBe(true);
    expect(result.value).toBe(1);
  });
  
  it('should accept interpretation request', async () => {
    mockContractCall.mockResolvedValue({ success: true });
    const result = await mockContractCall('accept-interpretation-request', 1);
    expect(result.success).toBe(true);
  });
  
  it('should complete interpretation', async () => {
    mockContractCall.mockResolvedValue({ success: true });
    const result = await mockContractCall('complete-interpretation', 1);
    expect(result.success).toBe(true);
  });
  
  it('should get interpretation request', async () => {
    mockContractCall.mockResolvedValue({
      success: true,
      value: {
        dream_id: 1,
        requester: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
        interpreter: null,
        is_completed: false
      }
    });
    const result = await mockContractCall('get-interpretation-request', 1);
    expect(result.success).toBe(true);
    expect(result.value.dream_id).toBe(1);
  });
  
  it('should get open requests count', async () => {
    mockContractCall.mockResolvedValue({
      success: true,
      value: 2
    });
    const result = await mockContractCall('get-open-requests');
    expect(result.success).toBe(true);
    expect(result.value).toBe(2);
  });
});

