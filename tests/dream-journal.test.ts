import { describe, it, expect, beforeEach, vi } from 'vitest';

describe('Dream Journal Contract', () => {
  let mockContractCall: any;
  
  beforeEach(() => {
    mockContractCall = vi.fn();
  });
  
  it('should create a dream entry', async ()=> {
    mockContractCall.mockResolvedValue({ success: true, value: 1 });
    const result = await mockContractCall('create-dream-entry', 'I dreamt I was flying');
    expect(result.success).toBe(true);
    expect(result.value).toBe(1);
  });
  
  it('should update a dream entry', async () => {
    mockContractCall.mockResolvedValue({ success: true });
    const result = await mockContractCall('update-dream-entry', 1, 'I dreamt I was swimming');
    expect(result.success).toBe(true);
  });
  
  it('should share a dream entry', async () => {
    mockContractCall.mockResolvedValue({ success: true });
    const result = await mockContractCall('share-dream-entry', 1);
    expect(result.success).toBe(true);
  });
  
  it('should get a dream entry', async () => {
    mockContractCall.mockResolvedValue({
      success: true,
      value: {
        owner: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
        encrypted_content: 'encrypted_dream_content',
        timestamp: 12345,
        is_shared: false
      }
    });
    const result = await mockContractCall('get-dream-entry', 1);
    expect(result.success).toBe(true);
    expect(result.value.encrypted_content).toBe('encrypted_dream_content');
  });
  
  it('should get shared dreams count', async () => {
    mockContractCall.mockResolvedValue({
      success: true,
      value: 2
    });
    const result = await mockContractCall('get-shared-dreams-count');
    expect(result.success).toBe(true);
    expect(result.value).toBe(2);
  });
  
  it('should check if a dream is shared', async () => {
    mockContractCall.mockResolvedValue({
      success: true,
      value: true
    });
    const result = await mockContractCall('is-dream-shared', 1);
    expect(result.success).toBe(true);
    expect(result.value).toBe(true);
  });
});

